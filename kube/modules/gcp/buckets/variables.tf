variable "airwave_stack_name" {
  type        = string
  description = "Storage bucket name"
}

variable "project_id" {
  type        = string
  description = "Gcp project where resources will be created"
}

variable "region" {
  type        = string
  description = "Location for bucket"
}
