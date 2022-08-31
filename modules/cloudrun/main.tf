resource "google_cloud_run_service" "default" {
    name     = "${var.cloudrun_service_name}"
    location = "us-central1"
    template {
      spec {
            containers {
                image = "${var.image_url}"
            }
      }
    }
    traffic {
      percent         = 100
      latest_revision = true
    }
}

resource "google_service_account" "sa" {
  account_id   = "${var.sa_name}"
  display_name = "Cloud Run Pub/Sub Invoker"
}

resource "google_cloud_run_service_iam_binding" "binding" {
  location = google_cloud_run_service.default.location
  service = google_cloud_run_service.default.name
  role = "roles/run.invoker"
  members = ["serviceAccount:${google_service_account.sa.email}"]
}
