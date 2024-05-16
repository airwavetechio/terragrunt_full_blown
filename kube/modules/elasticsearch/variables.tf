variable "namespace" {
  type        = string
  description = "The Kubernetes namespace to deploy to."
}

variable "image_pull_secret_name" {
  type        = string
  description = "The name of the secret used to pull container images."
}


variable "container_image" {
  type        = string
  description = "Variables for elasticsearch server info"
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

variable "custom" {
  type = map(object({
    identifier = string
    gcs_sa = optional(list(object({
      mount_path = string
      name       = string
    })))
    elasticsearch_config = optional(list(object({
      mount_path = string
      sub_path   = string
      name       = string
      claim_name = string
    })))
  }))
  default = {}
}

variable "airwave_version" {
  type     = string
  nullable = false
}
