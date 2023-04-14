data "google_container_cluster" "this" {
  name     = "${var.project_id}-gke"
  location = var.region
}