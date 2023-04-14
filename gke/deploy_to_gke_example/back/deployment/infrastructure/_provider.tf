terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

provider "google" {
  credentials = file("credentials/key.json")

  project = var.project_id
  region  = var.region
  zone    = "us-central1-c"
}
data "google_client_config" "provider" {}

provider "kubernetes" {
    host     = "https://${data.google_container_cluster.this.endpoint}"

  client_certificate     = data.google_container_cluster.this.master_auth.0.client_certificate
  client_key             = data.google_container_cluster.this.master_auth.0.client_key
  cluster_ca_certificate = base64decode(data.google_container_cluster.this.master_auth.0.cluster_ca_certificate)
  token = data.google_client_config.provider.access_token     
}