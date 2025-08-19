terraform {
  required_version = ">= 1.6"
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      # можно зафиксировать минимальную:
      # version = ">= 0.140"
    }
  }
}
