variable "namespace" {
  type = string
}

variable "app_name" {
  type = string
}

variable "container_image" {
  type = string
}


variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "aws_access_key" {
  type    = string
  default = null
}

variable "aws_secret_key" {
  type    = string
  default = null

}

variable "google_application_credentials" {
  type    = string
  default = null
}

variable "azure_storage_account" {
  type    = string
  default = null
}

variable "azure_storage_key" {
  type    = string
  default = null
}

variable "minio_command" {
  type = list(string)
}

variable "image_pull_secret_name" {
  type = string
}

variable "pv_name" {
  type = string
}

variable "pvc_size" {
  type = string
}

variable "storage_class" {
  type = string
}

variable "buckets" {
  type = list(string)
}

variable "airwave_version" {
  type     = string
  nullable = false
}
