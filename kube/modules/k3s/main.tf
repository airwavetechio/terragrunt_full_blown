resource "null_resource" "ansible_deploy" {
  triggers = merge(
    {
      for filename in fileset(local.ansible_workdir, "**") :
      filename => filebase64sha256("${local.ansible_workdir}/${filename}")
      if !startswith(basename(filename), ".")
    },
    # Use the 'content' field and hash it explicitly, because the derived `content_base64sha256`
    # field was only known after the apply and it therefore always effectively dirty.
    { "${local.ansible_inventory_basename}" = base64sha256(local_file.ansible_inventory.content) },
  )
  provisioner "local-exec" {
    command     = "ansible-galaxy collection install -r requirements.yml && ansible-galaxy role install -r requirements.yml && ansible-playbook -i inventory.yml k3s.yml"
    working_dir = local.ansible_workdir
  }
  depends_on = [
    local_file.ansible_inventory
  ]
}

data "external" "kubeconfig" {
  program = ["ssh", "${var.node.user}@${var.node.host}", "cat ${var.kube_config_json_path}"]
  depends_on = [
    null_resource.ansible_deploy
  ]
}

resource "random_password" "k3s_token" {
  length  = 16
  special = false
}
