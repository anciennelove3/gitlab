variable "folder_id" {
  type = string
}

variable "zone" {
  type    = string
  default = "ru-central1-a"
}

variable "project" {
  type    = string
  default = "project-ancienne"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "domain" {
  type    = string
  default = null
}

locals {
  name_prefix = "${var.project}-${var.env}"
  labels = {
    project = var.project
    env     = var.env
    owner   = "platform"
  }
}
