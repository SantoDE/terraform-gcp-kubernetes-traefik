# Setup GKE Cluster
resource "google_container_cluster" "default" {
  name               = "tf-gke-k8s"
  zone               = "${var.zone}"
  initial_node_count = 3
  min_master_version = "${data.google_container_engine_versions.default.latest_node_version}"
  network            = "${google_compute_subnetwork.default.name}"
  subnetwork         = "${google_compute_subnetwork.default.name}"

  node_config {
    machine_type = "${var.gke_machine_type}"
  }
}

output cluster_zone {
  value = "${google_container_cluster.default.zone}"
}

output "client_certificate" {
  value = "${google_container_cluster.default.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.default.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.default.master_auth.0.cluster_ca_certificate}"
}

output "cluster_instance_groups" {
  value = "${google_container_cluster.default.instance_group_urls}"
}

output cluster_name {
  value = "${google_container_cluster.default.name}"
}
