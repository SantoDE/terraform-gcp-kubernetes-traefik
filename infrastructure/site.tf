module "gke-cluster" {
  source = "./cluster"

  gcp_project_id   = "${var.project_id}"
  gcp_project_name = "${var.project_name}"
}

module "loadbalancing" {
  source = "./loadbalancing"

  client_cert     = "${module.gke-cluster.client_certificate}"
  client_key      = "${module.gke-cluster.client_key}"
  cluster_ca_cert = "${module.gke-cluster.cluster_ca_certificate}"
  project_id      = "${module.gke-cluster.project}"
}

output cluster_zone {
  value = "${module.gke-cluster.cluster_zone}"
}

output "cluster_name" {
  value = "${module.gke-cluster.cluster_name}"
}
