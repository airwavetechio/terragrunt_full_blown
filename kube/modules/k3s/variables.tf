variable "node" {
  type = object({
    host        = string
    user        = string
    internal_ip = optional(string)
  })
}

variable "cluster_version" {
  type = string
}

variable "accelerator_platform" {
  type = string
}

variable "kube_config_json_path" {
  type    = string
  default = "/etc/rancher/k3s/k3s.json"
}

variable "domain_name" {
  type = string
}

variable "proxy_service_url" {
  type = string
}

variable "use_custom_dns" {
  type    = bool
  default = false
}
