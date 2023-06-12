variable "project"        { type = string }
variable "env"            { type = string }
variable "project_number" { type = number }

provider "google" {
  version = "~> 4.31.0"
  project = var.project
}

resource "google_pubsub_topic" "crunch_landing_topic" {
  name    = "crunch-landing-topic"
  project = var.project
}

data "google_storage_project_service_account" "gcs_account" {
}

#Role binding for notification with Storage bucket service account
resource "google_pubsub_topic_iam_binding" "binding" {
  project  = var.project
  topic    = google_pubsub_topic.crunch_landing_topic.name
  role     = "roles/pubsub.publisher"
  members  = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
//  members  = ["serviceAccount:service-411828846632@gs-project-accounts.iam.gserviceaccount.com"]
}

output "topic_name" {
  value = "${google_pubsub_topic.crunch_landing_topic.name}"
}