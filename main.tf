
module "network" {
    source = "./modules/network"
}
resource "google_service_account" "svc_k8s" {
  account_id   = "svc-k8s"
  display_name = "Service Account k8s cluster"
}

module "node_master" {
  source = "./modules/node"
  name= "k8s-master"
  node_type= "master"
  network= module.network.vpc_k8s_network_name
  subnetwork=module.network.k8s_subnetwork_name
  network_ip="10.2.0.2"
  svc_email =google_service_account.svc_k8s.email
}

// module "node_worker1" {
//   source = "./modules/node"
//   name= "k8s-worker-1"
//   node_type= "worker"
//   network= module.network.vpc_k8s_network_name
//   subnetwork=module.network.k8s_subnetwork_name
//   network_ip="10.2.0.3"
//   svc_email =google_service_account.svc_k8s.email
// }

// module "node_worker2" {
//   source = "./modules/node"
//   name= "k8s-worker-2"
//   node_type= "worker"
//   network= module.network.vpc_k8s_network_name
//   subnetwork=module.network.k8s_subnetwork_name
//   network_ip="10.2.0.4"
//   svc_email =google_service_account.svc_k8s.email
// }