resource "kubernetes_manifest" "nvidia_driver" {
  manifest = yamldecode(templatefile(
    "${path.module}/files/nvidia-driver-installer.yaml",
    {
      NVIDIA_DRIVER_VERSION = "525.105.17"
    }
  ))
  # Need to add these explicitly or we get errors about generations.
  # https://jenkins.randomclient.com/job/K8S/job/robert-test-gcp/47/console
  computed_fields = [
    "metadata.labels",
    "metadata.annotations"
  ]
  lifecycle {
    ignore_changes = [
      manifest.metadata.labels,
      manifest.metadata.annotations
    ]
  }
}

resource "kubernetes_secret" "backup-api-token_secret" {
  metadata {
    name      = "backup-api-secret-token"
    namespace = var.backup.namespace
  }

  data = {
    "token.json" = var.google_service_account_key
  }
}

resource "kubernetes_secret" "gcs_secret" {
  metadata {
    name      = "gcs-secret"
    namespace = var.ingest.namespace
  }

  data = {
    "gcs-sa.json" = var.google_service_account_key
  }
}

resource "kubernetes_persistent_volume_claim" "elasticsearch_config" {
  metadata {
    name      = var.ingest.pvc_name
    namespace = var.ingest.namespace
  }
  spec {
    storage_class_name = var.ingest.storage_class_name
    access_modes       = [var.ingest.access_modes]
    resources {
      requests = {
        storage = var.ingest.pvc_size
      }
    }
  }
  wait_until_bound = false
}

resource "helm_release" "kube-state-metrics" {
  name = "kube-state-metrics"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-state-metrics"
  version    = "5.8.1"
  namespace  = var.monitoring_namespace
}
