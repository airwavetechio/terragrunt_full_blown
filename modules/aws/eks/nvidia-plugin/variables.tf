variable "namespace" {
  description = "Kubernetes Namespace"
  type        = string
}

variable "create_namespace" {
  description = "Create a Kubernetes Namespace"
  type        = bool
  default     = false
}