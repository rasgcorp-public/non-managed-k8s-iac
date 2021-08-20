terraform {
  backend "gcs" {
    bucket = "tf-backend-pocs"
    prefix = "terraform/non-managed-k8s"
    credentials = "svc-terraform.json"
  }
}

provider "google" {
  project = "pocs-sandbox"
  credentials = "svc-terraform.json"
}