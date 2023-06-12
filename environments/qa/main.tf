locals {
  project_id = "emea-crunch-gbl-emea-qa"
  env        = "qa"
  location   = "EU"
  #usecase    = "credit"
  region     = "europe-west1"
  project_number = 612115810401
}

terraform {
  required_version = "~> 1.1.2"
  backend "gcs" {
    bucket = "emea-crunch-gbl-emea-dv-gcs-tfstate"
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

# Init Module to enable APIs

# Init Module for SA creation
module "sa-setup" {
  source  = "../../modules/IAMServiceAccount"
  project = "${local.project_id}"
  env     = "${local.env}"
}
# Module for pubsub topic creation
module "pubsub-topic" {
  source  = "../../modules/PubSubTopic"
  project = "${local.project_id}"
  env     = "${local.env}"
  project_number = "${local.project_number}"
}
# Module for Pub sub subscription
module "pubsub-subscr" {
  source  = "../../modules/PubSubSubscription"
  project = "${local.project_id}"
  env     = "${local.env}"
  url     = "${module.cloudrun-setup.url}"
}

# Module to create storage buckets
module "bucket-setup" {
  source  = "../../modules/StorageBucket"
  project = "${local.project_id}"
  env     = "${local.env}"
  location   = "${local.location}"
  topic_name = "${module.pubsub-topic.topic_name}"  
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


# Module for Cloud Scheduler
module "cloud-scheduler" {
  source  = "../../modules/CloudScheduler"
  project    = "${local.project_id}"
  env        = "${local.env}"
  topic_name = "${module.pubsub-topic.topic_name}"
}
