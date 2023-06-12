variable "project" { type = string }
variable "env" { type = string }
variable "topic_name" {type = string}

provider "google" {
  version = "~> 4.31.0"
  project = var.project
}

resource "google_cloud_scheduler_job" "job" {
  name        = "trigger_cloudrun"
  description = "scheduled job to trigger CRUNCH data ingestion cloud run service"
  schedule    = "0 9,12,15,18,21 * * *"
  region      = "europe-west1"
  time_zone   = "Europe/Paris"

  pubsub_target {
    topic_name = "projects/${var.project}/topics/${var.topic_name}" 
    attributes = {"bucketId":"crunch-gcs-fr-landing-eu-${var.env}", "eventType": "SCHEDULER", "objectId": "fr_lpd_galerieslafayette_b+o,fr_lpd_douglasfranchise_o,fr_lpd_oia_b+o,fr_lpd_uhps_b,fr_lpd_beautysuccess_b+o,fr_lpd_passionbeaute_b+o,fr_lpd_printemps_b+o"}
  }
}
