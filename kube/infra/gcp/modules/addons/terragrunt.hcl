terraform {
  source = "../../../../modules/gcp/addons"
}

include "k8s_provider" {
  path = find_in_parent_folders("k8s.hcl")
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

dependency "baremetal" {
  config_path = "../baremetal"
  mock_outputs = {
    ingest_stack = {
      namespace = "mocked"
    }
    foundation_stack = {
      namespace = "mocked"
    }
    monitoring_stack = {
      namespace = "mocked"
    }
  }
  mock_outputs_merge_strategy_with_state = "deep_map_only"
}

dependency "buckets" {
  config_path = "../buckets"
  mock_outputs = {
    google_service_account_key = {
      private_key = base64encode("mocked")
    }
  }
  mock_outputs_merge_strategy_with_state = "deep_map_only"
}

dependency "namespaces" {
  config_path  = "../namespaces"
  skip_outputs = true
}

inputs = {
  google_service_account_key = base64decode(dependency.buckets.outputs.google_service_account_key.private_key)

  ingest = {
    namespace          = dependency.baremetal.outputs.ingest_stack.namespace
    pvc_name           = "elasticsearch-config"
    storage_class_name = "standard-rwo"
    access_modes       = "ReadWriteOnce"
    pvc_size           = "30Gi"
  }
  backup = {
    namespace = dependency.baremetal.outputs.foundation_stack.namespace
  }
  monitoring_namespace = dependency.baremetal.outputs.monitoring_stack.namespace
}
