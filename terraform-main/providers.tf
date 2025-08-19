# terraform {
#   backend "s3" {
#     endpoint                    = "storage.yandexcloud.net"
#     bucket                      = "tf-state-yourteam"
#     key                         = "project-ancienne/dev/terraform.tfstate"
#     region                      = "ru-central1"
#     skip_credentials_validation = true
#     skip_region_validation      = true
#     force_path_style            = true
#   }
# }

provider "yandex" {
  folder_id = var.folder_id
  zone      = var.zone
}
