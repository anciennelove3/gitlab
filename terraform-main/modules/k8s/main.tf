data "yandex_client_config" "client" {}

# SA для мастера и нод
resource "yandex_iam_service_account" "k8s" {
  name        = "${var.name_prefix}-k8s-sa"
  description = "SA for Managed Kubernetes (master & nodes)"
}

resource "yandex_kubernetes_cluster" "this" {
  name       = "${var.name_prefix}-k8s"
  network_id = var.network_id

  master {
    master_location {
      zone      = "ru-central1-a"
      subnet_id = var.subnet_ids_by_zone["ru-central1-a"]
    }
    public_ip = true
  }

  service_account_id      = yandex_iam_service_account.k8s.id
  node_service_account_id = yandex_iam_service_account.k8s.id

  release_channel = var.release_channel
  labels          = var.labels
}

resource "yandex_kubernetes_node_group" "general" {
  cluster_id = yandex_kubernetes_cluster.this.id
  name       = "${var.name_prefix}-ng-general"

  # автоскейл -> одна зона
  scale_policy {
    auto_scale {
      min     = 1
      max     = 3
      initial = 1
    }
  }

  allocation_policy {
    location { zone = "ru-central1-a" }
  }

  instance_template {
    platform_id = "standard-v3"

    resources {
      cores  = 2
      memory = 4
    }

    boot_disk {
      size = 30
      type = "network-ssd"
    }

    network_interface {
      subnet_ids = [var.subnet_ids_by_zone["ru-central1-a"]]
      nat        = false
    }

    labels = merge(var.labels, { role = "general" })
  }

  labels = var.labels
}
