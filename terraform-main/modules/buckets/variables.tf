variable "name_prefix" { type = string }
variable "labels"      { type = map(string) }
variable "buckets" {
  description = "map: suffix -> settings"
  type = map(object({
    versioning             = bool
    lifecycle_days_to_cold = number
  }))
}
