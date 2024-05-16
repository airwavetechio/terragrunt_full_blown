resource "helm_release" "nvidia-plugin" {
  chart      = "nvidia-device-plugin"
  name       = "nvidia-device-plugin"
  namespace  = var.namespace
  repository = "https://nvidia.github.io/k8s-device-plugin"
  version    = "0.14.0"
  create_namespace = var.create_namespace

  values = [<<EOF
nodeSelector:
  node_type: gpu
EOF
  ]
}