output "vpc_k8s_network_name" {
  value = google_compute_network.vpc_k8s_network.name
}

output "k8s_subnetwork_name" {
  value = google_compute_subnetwork.k8s_subnetwork.name
}