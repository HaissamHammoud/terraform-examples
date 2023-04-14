# Chose GKE intead of EKS because it fits more with the neuraumed infraestructure 
# 

resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke"
  location = var.region
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  // configurações de rede internas do cluster
   // Necessario para o uso de network policies no cluster
  network_policy {
    enabled  = true
    provider = "CALICO" // CALICO is currently the only supported provider
  }

  addons_config {
    network_policy_config {
      disabled = false
    }
  }
  //Necessario no caso de mudanças dentro do cluster
  lifecycle {
    ignore_changes = [
      ip_allocation_policy,
      network,
      subnetwork,
    ]
  }
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  
  # Add logs and monitoring to the cluster
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }
    # control the size not to excede account storage free limit
    disk_size_gb = var.node_disk_size 

    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}