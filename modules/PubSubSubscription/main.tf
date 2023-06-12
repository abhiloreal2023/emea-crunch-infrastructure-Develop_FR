variable "project" { type = string }
variable "env" { type = string }
variable "url" { type = string }

provider "google" {
  version = "~> 4.31.0"
  project = var.project
}

resource "google_pubsub_subscription" "crunch_landing_sub" {
  ack_deadline_seconds = 600

  expiration_policy {
    ttl = "31536000s"
  }
  retry_policy {
    minimum_backoff = "599s"
  }
  message_retention_duration = "600s"
  name                       = "crunch-landing-sub"
  project                    = var.project
# Update SA email ID for Cloud Run and Endpoint #PB
  push_config {
    oidc_token {
      service_account_email = "crunch-sa-cloudrun@${var.project}.iam.gserviceaccount.com"
    }

    push_endpoint = var.url
  }

  topic = "projects/${var.project}/topics/crunch-landing-topic"
}
