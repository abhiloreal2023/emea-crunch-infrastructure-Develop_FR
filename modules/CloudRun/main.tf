variable "project" { type = string }
variable "env" { type = string }

provider "google" {
  version = "~> 4.31.0"
  project = var.project
}

resource "google_cloud_run_service" "emea-crunch-ingestion-api" {
    name     = "emea-crunch-ingestion-api"
    location = "europe-west1"
    autogenerate_revision_name = true
    
    template {
      spec {
            containers {
                image = "gcr.io/${var.project}/emea-crunch-ingestion-api"
              resources {
                limits = {
                  cpu = 6
                  memory = "16Gi"

                }
              }
 
            }
            container_concurrency = 5
            timeout_seconds = 1200
            service_account_name = "crunch-sa-cloudrun@${var.project}.iam.gserviceaccount.com"
      }
      metadata {
        annotations = {
            "autoscaling.knative.dev/maxScale"      = "1000"            
            }
        }
    }
    traffic {
      percent         = 100
      latest_revision = true
    }
    depends_on = [google_project_iam_binding.cloudrun-sa-iam-sau]
}

output "url" {
  value = "${google_cloud_run_service.emea-crunch-ingestion-api.status[0].url}"
}

#Cloud Run Service account role binding - Service Account User
resource "google_project_iam_binding" "cloudrun-sa-iam-sau" {
  project      = var.project
  role         = "roles/iam.serviceAccountUser"
  members      = ["serviceAccount:crunch-sa-cloudrun@${var.project}.iam.gserviceaccount.com"]
}
