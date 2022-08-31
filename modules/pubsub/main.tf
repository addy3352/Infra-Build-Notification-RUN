resource "google_pubsub_topic" "build" {
  name = "${var.topic_name}"
  message_retention_duration = "900s"
}
resource "google_pubsub_subscription" "build" {
  name  = "${var.subscription_name}"
  topic = google_pubsub_topic.build.name
  filter = "attributes.status = \"FAILURE\""
  push_config {
    push_endpoint = "${var.service_url}"
    oidc_token {
#      service_account_email = google_service_account.sa.email
      service_account_email = "${var.sa_email}@${var.project_id}.iam.gserviceaccount.com"
    }
  }
  depends_on = [
    google_pubsub_topic.build  ]
}
