resource "local_file" "ansible_inventory" {

  filename = "${local.ansible_workdir}/${local.ansible_inventory_basename}"
  content = yamlencode({
    all = {
      vars = {
        "airwave_install_k3s_version"  = var.cluster_version
        "airwave_k3s_token"            = random_password.k3s_token.result
        "airwave_accelerator_platform" = var.accelerator_platform
        "ansible_python_interpreter"   = "/usr/bin/python3"
        "kube_config_json_path"        = var.kube_config_json_path
        "domain_name"                  = var.domain_name
        "proxy_service_url"            = var.proxy_service_url
        "use_custom_dns"               = var.use_custom_dns
        "nvidia_driver_version"        = "535"
      }
      children = {
        k3snodes = {
          hosts = {
            "master" = {
              ansible_host = var.node.host
              ansible_user = var.node.user
            }
          }
        }
      }
    }
  })
}
