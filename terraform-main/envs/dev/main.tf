terraform { required_version = ">= 1.6" }

module "vpc" {
  source      = "../../modules/vpc"
  name_prefix = local.name_prefix
  labels      = local.labels
}

module "k8s" {
  source             = "../../modules/k8s"
  name_prefix        = local.name_prefix
  labels             = local.labels
  network_id         = module.vpc.network_id
  subnet_ids_by_zone = module.vpc.subnet_ids_by_zone
}

module "buckets" {
  source      = "../../modules/buckets"
  name_prefix = local.name_prefix
  labels      = local.labels
  buckets = {
    media      = { versioning = true, lifecycle_days_to_cold = 60 }
    uploads    = { versioning = true, lifecycle_days_to_cold = 30 }
    thumbnails = { versioning = false, lifecycle_days_to_cold = 14 }
  }
}

module "registry" {
  source      = "../../modules/registry"
  name_prefix = local.name_prefix
  labels      = local.labels
}

# DNS модуль включится, только если указать domain != null
module "dns" {
  count  = var.domain == null ? 0 : 1
  source = "../../modules/dns"
  domain = var.domain
  labels = local.labels
}

output "k8s_cluster_name" { value = module.k8s.cluster_name }
output "registry_address" { value = module.registry.registry_address }
output "buckets" { value = module.buckets.bucket_names }
output "dns_name_servers" { value = try(module.dns[0].name_servers, []) }
