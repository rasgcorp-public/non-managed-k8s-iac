resource "google_compute_network" "vpc_k8s_network" {
  name = "vpc-k8s-network"
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "firewall_vpc_k8s_external_access" {
  name    = "firewall-vpc-k8s-remote-access"
  network = google_compute_network.vpc_k8s_network.name

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22","6443"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "firewall_vpc_k8s_internal_access" {
  name    = "firewall-vpc-k8s-internal-access"
  network = google_compute_network.vpc_k8s_network.name

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "ipip"
  }
  allow {
    protocol = "icmp"    
  }
  source_ranges = ["10.2.0.0/28"]
}

resource "google_compute_subnetwork" "k8s_subnetwork" {
  name          = "k8s-subnetwork"
  ip_cidr_range = "10.2.0.0/28"
  region        = "us-east1"
  network       = google_compute_network.vpc_k8s_network.id
}

resource "google_compute_subnetwork" "dbs_subnetwork" {
  name          = "dbs-subnetwork"
  ip_cidr_range = "10.2.0.16/28"
  region        = "us-east1"
  network       = google_compute_network.vpc_k8s_network.id
}