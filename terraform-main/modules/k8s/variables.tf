variable "name_prefix" { type = string }
variable "labels"      { type = map(string) }
variable "network_id"  { type = string }

# карта "зона -> subnet_id"
variable "subnet_ids_by_zone" { type = map(string) }

variable "release_channel" {
  type    = string
  default = "STABLE"
}
