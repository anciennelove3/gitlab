output "network_id" {
  value = yandex_vpc_network.this.id
}

output "subnet_ids" {
  value = [for s in yandex_vpc_subnet.subnets : s.id]
}

# карта "зона -> id подсети"
output "subnet_ids_by_zone" {
  value = { for z, s in yandex_vpc_subnet.subnets : z => s.id }
}
