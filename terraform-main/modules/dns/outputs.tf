# В текущем провайдере ресурс зоны не отдаёт NS.
# Отдадим полезные атрибуты, которые точно есть.
output "zone_id" {
  value = yandex_dns_zone.this.id
}

output "zone" {
  value = yandex_dns_zone.this.zone
}

