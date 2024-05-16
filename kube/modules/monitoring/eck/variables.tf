variable "namespace" {
  type = string
}

variable "pv_name" {
  type = string
}


variable "eck_version" {
  type = string
  default = "8.8.0"
}

variable "eck_storage_size" {
  type = string
}