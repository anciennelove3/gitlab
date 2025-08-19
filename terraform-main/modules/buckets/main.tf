resource "yandex_storage_bucket" "b" {
  for_each = var.buckets
  bucket   = "${var.name_prefix}-${each.key}"

  lifecycle_rule {
    id      = "to-cold"
    enabled = each.value.lifecycle_days_to_cold > 0
    transition {
      days          = each.value.lifecycle_days_to_cold
      storage_class = "COLD"
    }
  }

  tags = var.labels
}

