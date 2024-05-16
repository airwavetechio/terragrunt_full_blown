resource "google_container_cluster" "gke_cluster" {
  name               = var.airwave_stack_name
  project            = var.project_id
  location           = var.location
  min_master_version = var.gke_version

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.vpc_name
  subnetwork = var.vpc_subnetwork
  ip_allocation_policy {

  }
  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }
  master_authorized_networks_config {
    gcp_public_cidrs_access_enabled = false
    # ToDo_Gia
    cidr_blocks {
      cidr_block = "0.0.0.0/0"
    }
  }
  release_channel {
    channel = "UNSPECIFIED"
  }
}


# Separately Managed GPU Node Pool
resource "google_container_node_pool" "gpu_nodes" {
  name       = "gpu-nodepool"
  location   = var.location
  project    = var.project_id
  cluster    = google_container_cluster.gke_cluster.name
  node_count = var.gke_num_gpu_nodes
  version    = var.gke_version


  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = var.gpu_node_type
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    disk_size_gb = 100
    image_type   = "ubuntu_containerd"
    guest_accelerator {
      type  = "nvidia-tesla-t4"
      count = 1
    }
  }
  management {
    auto_upgrade = false
  }
  depends_on = [
    google_container_cluster.gke_cluster
  ]
}

# Separately Managed Node Pool
resource "google_container_node_pool" "nodes" {
  name       = "nodepool"
  location   = var.location
  project    = var.project_id
  cluster    = google_container_cluster.gke_cluster.name
  node_count = var.gke_num_nodes
  version    = var.gke_version


  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = var.node_type
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    disk_size_gb = 100
    image_type   = "ubuntu_containerd"
  }
  management {
    auto_upgrade = false
  }
  depends_on = [
    google_container_cluster.gke_cluster
  ]
}
