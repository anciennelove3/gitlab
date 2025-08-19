resource "yandex_dns_zone" "this" {
  name        = replace(var.domain, ".", "-")
  zone        = "${var.domain}."
  public      = true
  description = "Managed by Terraform"
  labels      = var.labels
}
