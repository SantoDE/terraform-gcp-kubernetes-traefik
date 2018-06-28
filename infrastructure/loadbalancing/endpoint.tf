resource "google_compute_address" "default" {
  name    = "tf-gke-k8s-lb"
  region  = "${var.region}"
  project = "${var.project_id}"
}
