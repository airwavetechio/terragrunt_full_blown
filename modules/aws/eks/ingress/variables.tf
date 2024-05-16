#-------Ingress-------
variable "eks_cluster_id" {
  description = "EKS Cluster Id"
  type        = string
}

variable "ingress_namespace" {
  description = "Ingress namespace"
  type        = string
  default     = "ingress"
}

variable "isPiensoStack" {
  default = true
  type    = bool
}

variable "subdomain" {
  type = string
}

variable "domain" {
  type    = string
  default = "airwave.com"
}
