variable "google_service_account_key" {
  type = string
}

variable "ingest" {
  type = object({
    namespace          = string
    pvc_name           = string
    storage_class_name = string
    access_modes       = string
    pvc_size           = string
  })
  description = "Variables for the ingest-elasticsearch"
}

variable "backup" {
  type = object({
    namespace = string
  })
  description = "Variables for the backup app"
}

variable "monitoring_namespace" {
  type = string
}
