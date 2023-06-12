variable "project" { type = string }
variable "env" { type = string }
variable "snClientID" { type = string }
variable "snClientSecret" { type = string }
variable "azStorageSecret" { type = string }

provider "google" {
  version = "~> 4.31.0"
  project = var.project
}

# Create Secret service-now-client-id
resource "google_secret_manager_secret" "service-now-client-id" {
  secret_id = "service-now-client-id"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "secret-version-service-now-client-id" {
  secret = google_secret_manager_secret.service-now-client-id.id

  secret_data = var.snClientID
}

# Create Secret service-now-client-secret 
resource "google_secret_manager_secret" "service-now-client-secret" {
  secret_id = "service-now-client-secret"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "secret-version-service-now-client-secret" {
  secret = google_secret_manager_secret.service-now-client-secret.id

  secret_data = var.snClientSecret
}

# Create Secret azure-storage-token 
resource "google_secret_manager_secret" "azure-storage-token" {
  secret_id = "AZURE_STORAGE_SAS_TOKEN"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "secret-version-azure-storage-token" {
  secret = google_secret_manager_secret.azure-storage-token.id

  secret_data = var.azStorageSecret
}