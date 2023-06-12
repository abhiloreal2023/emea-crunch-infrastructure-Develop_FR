variable "project" { type = string }
variable "env" { type = string }
variable "location" {type = string}
variable "topic_name" {type = string}

provider "google" {
  version = "~> 4.31.0"
  project = var.project
}

resource "google_storage_bucket" "emea_crunch_gbl_emea_qa_terraform" {
  force_destroy               = true
  location                    = var.location
  name                        = "emea-crunch-gbl-emea-${var.env}-terraform"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket" "crunch_gcs_archive" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-archive-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 90
    }
    action {
      type = "SetStorageClass"
      storage_class = "COLDLINE"
    }
  }

  lifecycle_rule {
    condition {
      age = 365
    }
    action {
      type = "SetStorageClass"
      storage_class = "ARCHIVE"
    }
  }
}

resource "google_storage_bucket" "crunch_gcs_common" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-common-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_eu_common" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-eu-common-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_sns_common" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-sns-common-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_fr_common" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-fr-common-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_bnl_common" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-bnl-common-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_ibe_common" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-ibe-common-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_itg_common" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-itg-common-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_dach_common" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-dach-common-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_cess_common" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-cess-common-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_za_common" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-za-common-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_config" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-config-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_error" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-error-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_landing_edi" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-landing-edi-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_landing" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-landing-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_eu_landing" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-eu-landing-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_sns_landing" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-sns-landing-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_fr_landing" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-fr-landing-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_bnl_landing" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-bnl-landing-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_ibe_landing" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-ibe-landing-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_itg_landing" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-itg-landing-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_dach_landing" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-dach-landing-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_cess_landing" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-cess-landing-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_za_landing" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-za-landing-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

# 
resource "google_storage_bucket" "crunch_gcs_landing_siso" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-landing-siso-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_output" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-output-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_gcs_staging" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch-gcs-staging-eu-${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "crunch_angular" {
  force_destroy               = true
  location                    = var.location
  name                        = "crunch_angular_${var.env}"
  project                     = var.project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

# This code is to create storage bucket notification
resource "google_storage_notification" "notification" {
//  bucket         = "crunch-gcs-landing-eu-${var.env}"
  bucket         = google_storage_bucket.crunch_gcs_landing.name
  payload_format = "JSON_API_V1"
  topic          = "projects/${var.project}/topics/crunch-landing-topic"
  event_types    = ["OBJECT_FINALIZE"]
  depends_on     = [var.topic_name]
}

resource "google_storage_notification" "fr_notification" {
//  bucket         = "crunch-gcs-fr-landing-eu-${var.env}"
  bucket         = google_storage_bucket.crunch_gcs_fr_landing.name
  payload_format = "JSON_API_V1"
  topic          = "projects/${var.project}/topics/crunch-landing-topic"
  event_types    = ["OBJECT_FINALIZE"]
  depends_on     = [var.topic_name]
}

resource "google_storage_notification" "za_notification" {
//  bucket         = "crunch-gcs-za-landing-eu-${var.env}"
  bucket         = google_storage_bucket.crunch_gcs_za_landing.name
  payload_format = "JSON_API_V1"
  topic          = "projects/${var.project}/topics/crunch-landing-topic"
  event_types    = ["OBJECT_FINALIZE"]
  depends_on     = [var.topic_name]
}

resource "google_storage_notification" "dach_notification" {
//  bucket         = "crunch-gcs-dach-landing-eu-${var.env}"
  bucket         = google_storage_bucket.crunch_gcs_dach_landing.name
  payload_format = "JSON_API_V1"
  topic          = "projects/${var.project}/topics/crunch-landing-topic"
  event_types    = ["OBJECT_FINALIZE"]
  depends_on     = [var.topic_name]
}

resource "google_storage_notification" "itg_notification" {
//  bucket         = "crunch-gcs-itg-landing-eu-${var.env}"
  bucket         = google_storage_bucket.crunch_gcs_itg_landing.name
  payload_format = "JSON_API_V1"
  topic          = "projects/${var.project}/topics/crunch-landing-topic"
  event_types    = ["OBJECT_FINALIZE"]
  depends_on     = [var.topic_name]
}

resource "google_storage_notification" "ibe_notification" {
//  bucket         = "crunch-gcs-ibe-landing-eu-${var.env}"
  bucket         = google_storage_bucket.crunch_gcs_ibe_landing.name
  payload_format = "JSON_API_V1"
  topic          = "projects/${var.project}/topics/crunch-landing-topic"
  event_types    = ["OBJECT_FINALIZE"]
  depends_on     = [var.topic_name]
}

resource "google_storage_notification" "bnl_notification" {
//  bucket         = "crunch-gcs-bnl-landing-eu-${var.env}"
  bucket         = google_storage_bucket.crunch_gcs_bnl_landing.name
  payload_format = "JSON_API_V1"
  topic          = "projects/${var.project}/topics/crunch-landing-topic"
  event_types    = ["OBJECT_FINALIZE"]
  depends_on     = [var.topic_name]
}

resource "google_storage_notification" "sns_notification" {
//  bucket         = "crunch-gcs-sns-landing-eu-${var.env}"
  bucket         = google_storage_bucket.crunch_gcs_sns_landing.name
  payload_format = "JSON_API_V1"
  topic          = "projects/${var.project}/topics/crunch-landing-topic"
  event_types    = ["OBJECT_FINALIZE"]
  depends_on     = [var.topic_name]
}

resource "google_storage_notification" "eu_notification" {
//  bucket         = "crunch-gcs-eu-landing-eu-${var.env}"
  bucket         = google_storage_bucket.crunch_gcs_eu_landing.name
  payload_format = "JSON_API_V1"
  topic          = "projects/${var.project}/topics/crunch-landing-topic"
  event_types    = ["OBJECT_FINALIZE"]
  depends_on     = [var.topic_name]
}

resource "google_storage_notification" "cess_notification" {
//  bucket         = "crunch-gcs-cess-landing-eu-${var.env}"
  bucket         = google_storage_bucket.crunch_gcs_cess_landing.name
  payload_format = "JSON_API_V1"
  topic          = "projects/${var.project}/topics/crunch-landing-topic"
  event_types    = ["OBJECT_FINALIZE"]
  depends_on     = [var.topic_name]
}

resource "google_storage_bucket_object" "copy-FR-stg-json-files" {
  for_each = fileset(path.module,"../BigQueryDataset/FR/schema/stg/t_*.json")

  name   = replace("FR/schema/stg/${each.value}","../BigQueryDataset/FR/schema/stg/","")
  bucket = google_storage_bucket.crunch_gcs_config.name

  source = "${path.module}/${each.value}"
  content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
}

resource "google_storage_bucket_object" "copy-FR-dom-json-files" {
  for_each = fileset(path.module,"../BigQueryDataset/FR/schema/dom/t_*.json")

  name   = replace("FR/schema/dom/${each.value}","../BigQueryDataset/FR/schema/dom/","")
  bucket = google_storage_bucket.crunch_gcs_config.name

  source = "${path.module}/${each.value}"
  content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
}

resource "google_storage_bucket_object" "copy-CESS-stg-json-files" {
  for_each = fileset(path.module,"../BigQueryDataset/CESS/schema/stg/*.json")

  name   = replace("CESS/schema/stg/${each.value}","../BigQueryDataset/CESS/schema/stg/","")
  bucket = google_storage_bucket.crunch_gcs_config.name

  source = "${path.module}/${each.value}"
  content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
}

resource "google_storage_bucket_object" "copy-CESS-dom-json-files" {
  for_each = fileset(path.module,"../BigQueryDataset/CESS/schema/dom/*.json")

  name   = replace("CESS/schema/dom/${each.value}","../BigQueryDataset/CESS/schema/dom/","")
  bucket = google_storage_bucket.crunch_gcs_config.name

  source = "${path.module}/${each.value}"
  content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
}

# resource "google_storage_bucket_object" "copy-ZA-stg-json-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/ZA/schema/stg/t_*.json")

#   name   = replace("ZA/schema/stg/${each.value}","../BigQueryDataset/ZA/schema/stg/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
#   content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
# }

# resource "google_storage_bucket_object" "copy-ZA-dom-json-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/ZA/schema/dom/t_*.json")

#   name   = replace("ZA/schema/dom/${each.value}","../BigQueryDataset/ZA/schema/dom/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
#   content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
# }


# resource "google_storage_bucket_object" "copy-EU-stg-json-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/EU/schema/stg/t_*.json")

#   name   = replace("EU/schema/stg/${each.value}","../BigQueryDataset/EU/schema/stg/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

# resource "google_storage_bucket_object" "copy-EU-dom-json-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/EU/schema/dom/t_*.json")

#   name   = replace("EU/schema/dom/${each.value}","../BigQueryDataset/EU/schema/dom/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

# resource "google_storage_bucket_object" "copy-UKI-stg-json-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/UKI/schema/stg/t_*.json")

#   name   = replace("UKI/schema/stg/${each.value}","../BigQueryDataset/UKI/schema/stg/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

# resource "google_storage_bucket_object" "copy-UKI-dom-json-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/UKI/schema/dom/t_*.json")

#   name   = replace("UKI/schema/dom/${each.value}","../BigQueryDataset/UKI/schema/dom/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

 resource "google_storage_bucket_object" "copy-BNL-stg-json-files" {
   for_each = fileset(path.module,"../BigQueryDataset/BNL/schema/stg/t_*.json")

   name   = replace("BNL/schema/stg/${each.value}","../BigQueryDataset/BNL/schema/stg/","")
   bucket = google_storage_bucket.crunch_gcs_config.name

   source = "${path.module}/${each.value}"
   content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
 }

 resource "google_storage_bucket_object" "copy-BNL-dom-json-files" {
   for_each = fileset(path.module,"../BigQueryDataset/BNL/schema/dom/t_*.json")

   name   = replace("BNL/schema/dom/${each.value}","../BigQueryDataset/BNL/schema/dom/","")
   bucket = google_storage_bucket.crunch_gcs_config.name

   source = "${path.module}/${each.value}"
   content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
 }

# resource "google_storage_bucket_object" "copy-DACH-stg-json-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/DACH/schema/stg/t_*.json")

#   name   = replace("DACH/schema/stg/${each.value}","../BigQueryDataset/DACH/schema/stg/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

# resource "google_storage_bucket_object" "copy-DACH-dom-json-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/DACH/schema/dom/t_*.json")

#   name   = replace("DACH/schema/dom/${each.value}","../BigQueryDataset/DACH/schema/dom/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

# resource "google_storage_bucket_object" "copy-IBE-stg-json-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/IBE/schema/stg/t_*.json")

#   name   = replace("IBE/schema/stg/${each.value}","../BigQueryDataset/IBE/schema/stg/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

# resource "google_storage_bucket_object" "copy-IBE-dom-json-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/IBE/schema/dom/t_*.json")

#   name   = replace("IBE/schema/dom/${each.value}","../BigQueryDataset/IBE/schema/dom/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

# resource "google_storage_bucket_object" "copy-ITG-stg-json-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/ITG/schema/stg/t_*.json")

#   name   = replace("ITG/schema/stg/${each.value}","../BigQueryDataset/ITG/schema/stg/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

# resource "google_storage_bucket_object" "copy-ITG-dom-json-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/ITG/schema/dom/t_*.json")

#   name   = replace("ITG/schema/dom/${each.value}","../BigQueryDataset/ITG/schema/dom/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }
# resource "google_storage_bucket_object" "copy-SNS-stg-json-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/SNS/schema/stg/t_*.json")

#   name   = replace("SNS/schema/stg/${each.value}","../BigQueryDataset/SNS/schema/stg/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

# resource "google_storage_bucket_object" "copy-SNS-dom-json-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/SNS/schema/dom/t_*.json")

#   name   = replace("SNS/schema/dom/${each.value}","../BigQueryDataset/SNS/schema/dom/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

resource "google_storage_bucket_object" "copy-FR-sql-files" {
  for_each = fileset(path.module,"../BigQueryDataset/FR/sql/*.sql")

  name   = replace("FR/sql/${each.value}","../BigQueryDataset/FR/sql/","")
  bucket = google_storage_bucket.crunch_gcs_config.name

  source = "${path.module}/${each.value}"
  content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
}

resource "google_storage_bucket_object" "copy-CESS-sql-files" {
  for_each = fileset(path.module,"../BigQueryDataset/CESS/sql/*.sql")

  name   = replace("CESS/sql/${each.value}","../BigQueryDataset/CESS/sql/","")
  bucket = google_storage_bucket.crunch_gcs_config.name

  source = "${path.module}/${each.value}"
  content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
}

# resource "google_storage_bucket_object" "copy-ZA-sql-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/ZA/sql/*.sql")

#   name   = replace("ZA/sql/${each.value}","../BigQueryDataset/ZA/sql/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
#   content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
# }

# resource "google_storage_bucket_object" "copy-EU-sql-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/EU/sql/*.sql")

#   name   = replace("EU/sql/${each.value}","../BigQueryDataset/EU/sql/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }
# resource "google_storage_bucket_object" "copy-UKI-sql-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/UKI/sql/*.sql")

#   name   = replace("UKI/sql/${each.value}","../BigQueryDataset/UKI/sql/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

# resource "google_storage_bucket_object" "copy-DACH-sql-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/DACH/sql/*.sql")

#   name   = replace("DACH/sql/${each.value}","../BigQueryDataset/DACH/sql/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

 resource "google_storage_bucket_object" "copy-BNL-sql-files" {
   for_each = fileset(path.module,"../BigQueryDataset/BNL/sql/*.sql")

   name   = replace("BNL/sql/${each.value}","../BigQueryDataset/BNL/sql/","")
   bucket = google_storage_bucket.crunch_gcs_config.name

   source = "${path.module}/${each.value}"
   content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
 }

# resource "google_storage_bucket_object" "copy-ITG-sql-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/ITG/sql/*.sql")

#   name   = replace("ITG/sql/${each.value}","../BigQueryDataset/ITG/sql/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

# resource "google_storage_bucket_object" "copy-IBE-sql-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/IBE/sql/*.sql")

#   name   = replace("IBE/sql/${each.value}","../BigQueryDataset/IBE/sql/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

# resource "google_storage_bucket_object" "copy-SNS-sql-files" {
#   for_each = fileset(path.module,"../BigQueryDataset/SNS/sql/*.sql")

#   name   = replace("SNS/sql/${each.value}","../BigQueryDataset/SNS/sql/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

resource "google_storage_bucket_object" "copy-FR-config-files" {
  for_each = fileset(path.module,"Config/FR/*")
  name   = replace("FR/${each.value}","Config/FR/","")
  bucket = google_storage_bucket.crunch_gcs_config.name

  source = "${path.module}/${each.value}"
  content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
}

resource "google_storage_bucket_object" "copy-eu-config-files" {
  for_each = fileset(path.module,"Config/EU/*")
  name   = replace("EU/${each.value}","Config/EU/","")
  bucket = google_storage_bucket.crunch_gcs_config.name

  source = "${path.module}/${each.value}"
  content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
}

resource "google_storage_bucket_object" "copy-cess-config-files" {
  for_each = fileset(path.module,"Config/CESS/*")
  name   = replace("CESS/${each.value}","Config/CESS/","")
  bucket = google_storage_bucket.crunch_gcs_config.name

  source = "${path.module}/${each.value}"
  content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
}

 resource "google_storage_bucket_object" "copy-bnl-config-files" {
   for_each = fileset(path.module,"Config/BNL/*")
   name   = replace("BNL/${each.value}","Config/BNL/","")
   bucket = google_storage_bucket.crunch_gcs_config.name

   source = "${path.module}/${each.value}"
  content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
}

resource "google_storage_bucket_object" "copy-ZA-config-files" {
  for_each = fileset(path.module,"Config/ZA/*")
  name   = replace("ZA/${each.value}","Config/ZA/","")
  bucket = google_storage_bucket.crunch_gcs_config.name

  source = "${path.module}/${each.value}"
  content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
}


# resource "google_storage_bucket_object" "copy-dach-config-files" {
#   for_each = fileset(path.module,"Config/DACH/*")
#   name   = replace("DACH/${each.value}","Config/DACH/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

# resource "google_storage_bucket_object" "copy-sns-config-files" {
#   for_each = fileset(path.module,"Config/SNS/*")
#   name   = replace("SNS/${each.value}","Config/SNS/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

# resource "google_storage_bucket_object" "copy-itg-config-files" {
#   for_each = fileset(path.module,"Config/ITG/*")
#   name   = replace("ITG/${each.value}","Config/ITG/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

resource "google_storage_bucket_object" "copy-uki-config-files" {
  for_each = fileset(path.module,"Config/UKI/*")
  name   = replace("${each.value}","Config/UKI/","")
  bucket = google_storage_bucket.crunch_gcs_config.name

  source = "${path.module}/${each.value}"
  content_type = "text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
}

# resource "google_storage_bucket_object" "copy-ibe-config-files" {
#   for_each = fileset(path.module,"Config/IBE/*")

#   name   = replace("IBE/${each.value}","Config/IBE/","")
#   bucket = google_storage_bucket.crunch_gcs_config.name

#   source = "${path.module}/${each.value}"
# }

resource "google_storage_bucket_object" "copy-webapp-files" {
  for_each = fileset(path.module,"WebApp/*")

  name   = replace("${each.value}","WebApp/","")
  bucket = google_storage_bucket.crunch_angular.name

  source = "${path.module}/${each.value}"
  content_type = "application/vnd.openxmlformats-officedocument.wordprocessingml.document, text/plain, image/jpeg, text/csv, application/json, application/sql, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
}
