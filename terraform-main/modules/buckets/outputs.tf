output "bucket_names" {
  value = [for _, v in yandex_storage_bucket.b : v.bucket]
}
