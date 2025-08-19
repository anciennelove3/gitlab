resource "yandex_vpc_network" "this" {
  name   = "${var.name_prefix}-vpc"
  labels = var.labels
}

resource "yandex_vpc_gateway" "egress" {
  name = "${var.name_prefix}-egw"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  network_id = yandex_vpc_network.this.id
  name       = "${var.name_prefix}-rt"
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.egress.id
  }
}

locals {
  subnets = {
    "ru-central1-a" = "10.10.1.0/24"
    "ru-central1-b" = "10.10.2.0/24"
  }
}

resource "yandex_vpc_subnet" "subnets" {
  for_each       = local.subnets
  name           = "${var.name_prefix}-${each.key}"
  zone           = each.key
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = [each.value]
  route_table_id = yandex_vpc_route_table.rt.id
  labels         = var.labels
}
