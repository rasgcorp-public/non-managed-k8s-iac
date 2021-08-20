resource "google_compute_instance" "node" {
  name         = var.name
  machine_type = "e2-small"
  zone = "us-east1-b"

  tags = ["k8s", "npe", var.node_type]

  boot_disk {
    initialize_params {
      image = "k8s-node-2021-08-13t22-29-53z"
    }
  }

  network_interface {
    network = var.network
    subnetwork = var.subnetwork
    network_ip = var.network_ip
    access_config {
      
    }
  }

  metadata = {
    k8s = "non-prod-environment"
  }

  scheduling {
    preemptible = true
    automatic_restart = false
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.svc_email
    scopes = ["cloud-platform"]
  }
}