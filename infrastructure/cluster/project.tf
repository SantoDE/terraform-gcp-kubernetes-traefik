data "google_billing_account" "acct" {
  display_name = "${var.gcp_billing_accpint_name}"
  open         = true
}

resource "google_project" "project" {
  name       = "${var.gcp_project_name}"
  project_id = "${var.gcp_project_id}"

  billing_account = "${data.google_billing_account.acct.id}"
}

resource "google_project_service" "services" {
  project = "${google_project.project.project_id}"
  service = "compute.googleapis.com"
}

output project {
  value = "${google_project.project.project_id}"
}
