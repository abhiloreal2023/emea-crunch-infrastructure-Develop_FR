#Variable definitions - to be used in this module
variable "project" { type = string }
variable "env" { type = string }

#Provide information - for this module
provider "google" {
  version = "~> 4.31.0"
  project = var.project
}

#Providing Storage Admin, BQ data owner and BQ Admin access to cloud build service account

locals {
  service_account = var.env == "qa" ? "serviceAccount:612115810401@cloudbuild.gserviceaccount.com" : var.env == "np" ? "serviceAccount:411828846632@cloudbuild.gserviceaccount.com" : var.env == "pd" ? "serviceAccount:418048242570@cloudbuild.gserviceaccount.com" : ""
  dataaq_service_account = var.env == "pd" ? "serviceAccount:crunch-sa-dataaquasition-pd@emea-gcpsecurity-gbl-ww-pd.iam.gserviceaccount.com" : "serviceAccount:crunch-sa-dataaquasition-dv@emea-gcpsecurity-gbl-ww-pd.iam.gserviceaccount.com"
}



resource "google_project_iam_member" "storage-build-sa" {
  project      = var.project
  role         = "roles/storage.admin"
  member      = local.service_account
}


resource "google_project_iam_member" "bqadm-build-sa" {
  project      = var.project
  role         = "roles/bigquery.admin"
  member      = local.service_account
}

resource "google_project_iam_member" "bqdo-build-sa2" {
  project      = var.project
  role         = "roles/bigquery.dataOwner"
  member      = local.service_account
}

##Service Account Creation Follows##
#Service Account - Crate for Big Query Deploy
resource "google_service_account" "bq_deploy" {
  account_id   = "bq-deploy"
  description  = "Service account for deploying infrastructure on the project"
  display_name = "bq deploy service account"
  project      = var.project
}

#Service Account - Create for Cloud Run service and to be used for activities using Cloud Run
resource "google_service_account" "crunch_sa_cloudrun" {
  account_id   = "crunch-sa-cloudrun"
  description  = " Service account for Cloud run and associated activities"
  display_name = "crunch-sa-cloudrun"
  project      = var.project
}
#crunch-sa-cloudrun@emea-crunch-gbl-emea-qa.iam.gserviceaccount.com

# Servcice account - Create for App Engine
resource "google_service_account" "app_engine_sa" {
  account_id   = "emea-crunch-gb-emea-${var.env}"
  display_name = "App Engine default service account"
  project      = var.project
}

resource "google_service_account" "sellout_uki_sa" {
  account_id   = "sellout-uki-other-retailers"
  display_name = "Sellout_UKI_other_retailers"
  project      = var.project
}

resource "google_service_account" "crunch_sa" {
  account_id   = "crunch-sa"
  display_name = "crunch-sa"
  project      = var.project
}

##Service Account Role Bingins Follows##
#Cloud Run Service account role binding - Service Token Creator
resource "google_project_iam_binding" "cloudrun-sa-iam-tok" {
  project      = var.project
  role         = "roles/iam.serviceAccountTokenCreator"
  members      = ["serviceAccount:crunch-sa-cloudrun@${var.project}.iam.gserviceaccount.com"]
}

#Cloud Run Service account role member - Big Query Admin
resource "google_project_iam_member" "project-bq-admin1" {
 project      = var.project
 role         = "roles/bigquery.admin"
 member      = "serviceAccount:crunch-sa-cloudrun@${var.project}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "project-bq-admin2" {
 project      = var.project
 role         = "roles/bigquery.admin"
 member      = "serviceAccount:emea-crunch-gbl-emea-${var.env}@appspot.gserviceaccount.com"
}

resource "google_project_iam_member" "project-bq-admin3" {
 project      = var.project
 role         = "roles/bigquery.admin"
 member      = "group:EMEA-GCP-CRUNCH@loreal.com"
}

#Cloud Run Service account role binding - Big Query Data Owner
resource "google_project_iam_member" "project-bq-dataowner" {
  project      = var.project
  role         = "roles/bigquery.dataOwner"
  member      = "serviceAccount:crunch-sa-cloudrun@${var.project}.iam.gserviceaccount.com"
}

#Cloud Run Service account role member - Storage Admin
resource "google_project_iam_member" "project-storage-adm1" {
 project      = var.project
 role         = "roles/storage.admin"
 member      = "serviceAccount:crunch-sa-cloudrun@${var.project}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "project-storage-adm2" {
 project      = var.project
 role         = "roles/storage.admin"
 member      = "group:EMEA-GCP-EMEA-GB-BusinessKU@loreal.com"
}

resource "google_project_iam_member" "project-storage-adm3" {
 project      = var.project
 role         = "roles/storage.admin"
 member      = "group:EMEA-GCP-CRUNCH@loreal.com"
}

resource "google_project_iam_member" "project-storage-adm4" {
 project      = var.project
 role         = "roles/storage.admin"
 member      = "serviceAccount:emea-crunch-gbl-emea-${var.env}@appspot.gserviceaccount.com"
}

resource "google_project_iam_member" "project-storage-adm5" {
 project      = var.project
 role         = "roles/storage.admin"
 member      = "user:ana.nuevas@loreal.com"
}

resource "google_project_iam_member" "project-storage-adm6" {
 project      = var.project
 role         = "roles/storage.admin"
 member      = "user:alice.fieschi@loreal.com"
}

# resource "google_project_iam_member" "project-storage-adm7" {
#  project      = var.project
#  role         = "roles/storage.admin"
#  member      = "user:aurelie.quillard@loreal.com"
# }

# resource "google_project_iam_member" "project-storage-adm8" {
#  project      = var.project
#  role         = "roles/storage.admin"
#  member      = "user:sabrina.aitbraham@loreal.com"
# }

resource "google_project_iam_member" "project-storage-adm9" {
 project      = var.project
 role         = "roles/storage.admin"
 member      = "group:OAF-DataTeamFR-IT-GCP@loreal.com"
}

# resource "google_project_iam_member" "project-storage-adm9" {
#  project      = var.project
#  role         = "roles/storage.admin"
#  member      = "group:FR-LLD-CRUNCH-USER@loreal.com"
# }

resource "google_project_iam_member" "project-storage-adm10" {
 project      = var.project
 role         = "roles/storage.admin"
 member      = "user:mirceacostin.balan@loreal.com"
}

resource "google_project_iam_member" "project-storage-adm11" {
 project      = var.project
 role         = "roles/storage.admin"
 member      = local.dataaq_service_account
}

#Benelux Group storage access
resource "google_project_iam_member" "project-storage-bnl-multidiv" {
 project      = var.project
 role         = "roles/storage.admin"
 member      = "group:EMEA-GCP-BNL_MULTIDIV_DATA_STEWARDS@loreal.com"
}

resource "google_project_iam_member" "project-storage-bnl-emea" {
 project      = var.project
 role         = "roles/storage.admin"
 member      = "group:-ITG-GCP-BNL-EMEA-OWNERS@loreal.com"
}

# resource "google_project_iam_member" "project-storage-adm12" {
#  project      = var.project
#  role         = "roles/storage.admin"
#  member      = "user:melissa.ameurmeddah@loreal.com"
# }

resource "google_project_iam_member" "project-storage-czechusers" {
  project      = var.project
  role         = "roles/storage.admin"
  member      = "group:EMEA-GCP-CZECH_HUB@loreal.com"
}

resource "google_project_iam_member" "project-storage-ML-SA" {
  project      = var.project
  role         = "roles/storage.objectCreator"
  member      = "serviceAccount:956874723104-compute@developer.gserviceaccount.com"
}

#Cloud Run Service account role binding - Run Invoker
resource "google_project_iam_binding" "project-run-invoker" {
  project      = var.project
  role         = "roles/run.invoker"
  members      = ["serviceAccount:crunch-sa-cloudrun@${var.project}.iam.gserviceaccount.com"]
}

#Cloud Run Service account role binding - Run Invoker
resource "google_project_iam_member" "project-secret-accessor" {
  project      = var.project
  role         = "roles/secretmanager.secretAccessor"
  member      = "serviceAccount:crunch-sa-cloudrun@${var.project}.iam.gserviceaccount.com"
}

#Cloud Run Service account role binding - Run Invoker
resource "google_project_iam_member" "project-iap-users" {
  project      = var.project
  role         = "roles/iap.httpsResourceAccessor"
  member      = "group:EMEA-GCP-CRUNCH@loreal.com"
}

resource "google_project_iam_member" "project-iap-users1" {
  project      = var.project
  role         = "roles/iap.httpsResourceAccessor"
  member      = "group:EMEA-GCP-EMEA-GB-BusinessKU@loreal.com"
}

resource "google_project_iam_member" "project-iap-nordicusers" {
  project      = var.project
  role         = "roles/iap.httpsResourceAccessor"
  member      = "group:EMEA-GCP-EMEA-GCP-EU-NORDICS-ACCESSWH-SELLOUT@loreal.com"
}

resource "google_project_iam_member" "project-iap-czechusers" {
  project      = var.project
  role         = "roles/iap.httpsResourceAccessor"
  member      = "group:EMEA-GCP-CZECH_HUB@loreal.com"
}

resource "google_project_iam_member" "project-iap-selloutusers" {
  project      = var.project
  role         = "roles/iap.httpsResourceAccessor"
  member      = "group:EMEA-GCP-EU-EMEA-ACCESSWH-SELLOUT@loreal.com"
}

# resource "google_project_iam_member" "project-iap-user4" {
#   project      = var.project
#   role         = "roles/iap.httpsResourceAccessor"
#   member      = "user:aurelie.quillard@loreal.com"
# }

# resource "google_project_iam_member" "project-iap-user5" {
#   project      = var.project
#   role         = "roles/iap.httpsResourceAccessor"
#   member      = "user:sabrina.aitbraham@loreal.com"
# }

resource "google_project_iam_member" "project-iap-itg-bnl-users" {
  project      = var.project
  role         = "roles/iap.httpsResourceAccessor"
  member      = "group:-ITG-GCP-BNL-EMEA-OWNERS@loreal.com"
}

resource "google_project_iam_member" "project-iap-user6" {
  project      = var.project
  role         = "roles/iap.httpsResourceAccessor"
  member      = "user:romain.ng@loreal.com"
}

resource "google_project_iam_member" "project-iap-user7" {
  project      = var.project
  role         = "roles/iap.httpsResourceAccessor"
  member      = "user:mirceacostin.balan@loreal.com"
}

resource "google_project_iam_member" "project-iap-user8" {
  project      = var.project
  role         = "roles/iap.httpsResourceAccessor"
  member      = "group:SSA-GCP-SA-EMEA-DEVELOPERS@loreal.com"
}

resource "google_project_iam_member" "project-iap-fr_lld_users" {
  project = var.project
  role = "roles/iap.httpsResourceAccessor"
  member = "group:EMEA-GCP-FR-LLD-CRUNCH-USER@loreal.com"
}

resource "google_project_iam_member" "project-iap-fr_acd_users" {
  project = var.project
  role = "roles/iap.httpsResourceAccessor"
  member = "group:EMEA-GCP-EMEA-GCP-FR-ECOM_ACD-CRUNCH-USER@loreal.com"
}

resource "google_project_iam_member" "project-iap-fr_ppd_users" {
  project = var.project
  role = "roles/iap.httpsResourceAccessor"
  member = "group:DPPBI-FR-IT-GCP@loreal.com"
}

resource "google_project_iam_member" "project-iap-fr_ppd_users_2" {
  project = var.project
  role = "roles/iap.httpsResourceAccessor"
  member = "group:OAF-DataTeamFR-IT-GCP@loreal.com"
}

#Benelux group access
resource "google_project_iam_member" "project-iap-bnl_multidiv_users" {
  project = var.project
  role = "roles/iap.httpsResourceAccessor"
  member = "group:EMEA-GCP-BNL_MULTIDIV_DATA_STEWARDS@loreal.com"
}

resource "google_project_iam_member" "project-iap-bnl_emea_users" {
  project = var.project
  role = "roles/iap.httpsResourceAccessor"
  member = "group:-ITG-GCP-BNL-EMEA-OWNERS@loreal.com"
}

# resource "google_project_iam_member" "project-iap-user9" {
#   project = var.project
#   role = "roles/iap.httpsResourceAccessor"
#   member = "user:melissa.ameurmeddah@loreal.com"
# }
