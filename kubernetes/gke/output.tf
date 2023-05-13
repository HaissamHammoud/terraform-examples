# output "ip" {
#   value = google_compute_instance.vm_instance.network_interface.0.network_ip
# }

output "host"{
  value = google_container_cluster.primary.endpoint
}
output "credentials" {
    sensitive=true
    value = {
        clent_cert=google_container_cluster.primary.master_auth.0.client_certificate,
        client_key=google_container_cluster.primary.master_auth.0.client_key,
        cluster_ca=google_container_cluster.primary.master_auth.0.cluster_ca_certificate
    }
}