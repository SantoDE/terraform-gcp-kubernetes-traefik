module "gke-cluster" {
  source = "./cluster"

  gcp_project_id   = "${var.project_id}"
  gcp_project_name = "${var.project_name}"
}

output cluster_zone {
  value = "${module.gke-cluster.cluster_zone}"
}

output "cluster_name" {
  value = "${module.gke-cluster.cluster_name}"
}
