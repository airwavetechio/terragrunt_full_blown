terraform {
  required_version = ">= 1.0.9"
}

resource "null_resource" "update_desired_size" {

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]

    # Note: this requires the awscli to be installed locally where Terraform is executed
    command = <<-EOT
      AWS_REGION=${var.aws_region} aws eks update-nodegroup-config \
        --cluster-name ${var.cluster_name} \
        --nodegroup-name ${var.nodegroup_name} \
        --scaling-config desiredSize=${var.desired_size},minSize=${var.desired_size},maxSize=${var.desired_size}
    EOT
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]

    # Note: this requires the awscli to be installed locally where Terraform is executed
    command = <<-EOT
      AWS_REGION=${var.aws_region} aws eks update-nodegroup-config \
        --cluster-name ${var.cluster_name} \
        --nodegroup-name ${var.nodegroup_gpu_name} \
        --scaling-config desiredSize=${var.desired_gpu_size},maxSize=${var.desired_gpu_size}
    EOT
  }
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]

    # Note: this requires the awscli to be installed locally where Terraform is executed
    command = <<-EOT
      AWS_REGION=${var.aws_region} aws eks update-nodegroup-config \
        --cluster-name ${var.cluster_name} \
        --nodegroup-name ${var.nodegroup_gpu_name} \
        --scaling-config minSize=${var.desired_gpu_size}
    EOT
  }
}