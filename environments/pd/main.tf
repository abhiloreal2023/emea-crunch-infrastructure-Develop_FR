# Define Locals to be used across terraform (TF) Script
locals {
  project_id     = "emea-crunch-gbl-emea-pd"
  env            = "pd"
  location       = "EU"
  region         = "europe-west1"
  project_number = 418048242570
}

#Define Provider information and Backend for Infrastructure setup
terraform {
  required_version = "~> 1.1.2"
  backend "gcs" {
    bucket = "crunch-gbl-emea-pd-gcs-tfstate"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.31.0"
    }
  }
}

provider "google" {
  project = local.project_id
}

## Call Modules For Each resource ##
#Call Module for SA creation and Role binding
module "sa-setup" {
  source  = "../../modules/IAMServiceAccount"
  project = "${local.project_id}"
  env     = "${local.env}"
}

# Module to create storage buckets
module "bucket-setup" {
  source     = "../../modules/StorageBucket"
  project    = "${local.project_id}"
  env        = "${local.env}"
  location   = "${local.location}"
  topic_name = "${module.pubsub-topic.topic_name}"
}

#Module for pubsub topic creation
module "pubsub-topic" {
  source         = "../../modules/PubSubTopic"
  project        = "${local.project_id}"
  env            = "${local.env}"
  project_number = "${local.project_number}"
}
# Module for Pub sub subscription
module "pubsub-subscr" {
  source  = "../../modules/PubSubSubscription"
  project = "${local.project_id}"
  env     = "${local.env}"
  url     = "${module.cloudrun-setup.url}"
}

# Module to create Cloud Run instance/service
module "cloudrun-setup" {
  source  = "../../modules/CloudRun"
  project = "${local.project_id}"
  env     = "${local.env}"
}

# Module for Big Query Dataset
module "bq-dataset" {
  source  = "../../modules/BigQueryDataset"
  project = "${local.project_id}"
  env     = "${local.env}"
}

# Module for Secret Manager
module "secret-manager" {
  source  = "../../modules/SecretManager"
  project = "${local.project_id}"
  env     = "${local.env}"
  snClientID = "a5f8668c-e698-4089-ad23-ec6c4cc95708"
  snClientSecret = "gtl8Q~MYYBUkQHGsJZxnSdGbA3exfM1UljKaTaZo"
  azStorageSecret = "?sv=2021-10-04&st=2023-04-17T10%3A07%3A28Z&se=2050-12-31T10%3A07%3A00Z&sr=c&sp=racwdxl&sig=BozU4YJX5XCv1WlfCdpg6vhBj%2Bo9P8A%2BfnYKMCjqnTA%3D"
}

# Module for IPAddress
module "ip-address" {
  source      = "../../modules/IPAddress"
  project     = "${local.project_id}"
  env         = "${local.env}"
  ssl         = var.ssl
}

# Module for Cloud Scheduler
module "cloud-scheduler" {
  source  = "../../modules/CloudScheduler"
  project    = "${local.project_id}"
  env        = "${local.env}"
  topic_name = "${module.pubsub-topic.topic_name}"
}
