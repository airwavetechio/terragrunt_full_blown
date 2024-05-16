resource "helm_release" "eck-operator-crds" {
  name = "eck-operator-crds"

  repository = "https://helm.elastic.co"
  chart      = "eck-operator-crds"
  version    = "2.8.0"
  namespace  = var.namespace
}