variable "project" { type = string }
variable "env" { type = string }

provider "google" {
  version = "~> 4.31.0"
  project = var.project
}

# # Part 1 - Create BigQuery Dataset 
resource "google_bigquery_dataset" "d_crunch_audit" {
  dataset_id                 = "d_crunch_audit_eu_${var.env}"
  delete_contents_on_destroy = true
  description                = "Dataset for Crunch audit data"
  location                   = "EU"
  project                    = var.project
}

# # Part 2 - Create Big Query Table under dataset created above
resource "google_bigquery_table" "t_audit" {
  deletion_protection = false
  dataset_id = google_bigquery_dataset.d_crunch_audit.dataset_id
  project    = var.project 
  schema     = "[{\"name\":\"run_id\",\"type\":\"STRING\"},{\"name\":\"processed_timestamp\",\"type\":\"TIMESTAMP\"},{\"name\":\"hub_name\",\"type\":\"STRING\"},{\"name\":\"division_retailer_channel\",\"type\":\"STRING\"},{\"name\":\"begindate_enddate\",\"type\":\"STRING\"},{\"name\":\"status\",\"type\":\"STRING\"},{\"name\":\"failure_reason\",\"type\":\"STRING\"},{\"name\":\"input_files\",\"type\":\"STRING\"},{\"name\":\"output_filename\",\"type\":\"STRING\"},{\"name\":\"incident_id\",\"type\":\"STRING\"},{\"name\":\"sys_id\",\"type\":\"STRING\"},{\"name\":\"display_flag\",\"type\":\"BOOL\"}]"
  table_id   = "t_audit"
}

# Create Big Query Dataset for STG table (FR HUB)
resource "google_bigquery_dataset" "d_fr_stg" {
  dataset_id                  = "d_crunch_fr_stg_${var.env}"
  delete_contents_on_destroy = true
  description                = "Dataset for Crunch FR STG data"
  location                   = "EU"
  project                    = var.project
}

locals {
    fr_json_files_stg = fileset(path.module,"/FR/schema/stg/t_*.json")
}

# Create BigQuery STG tables (FR HUB)
resource "google_bigquery_table" "FR_STG_table" {
  for_each = local.fr_json_files_stg
  deletion_protection = false

  dataset_id = google_bigquery_dataset.d_fr_stg.dataset_id
  project = var.project
  table_id   = replace(replace(each.key, ".json", ""),"FR/schema/stg/","")
  schema     = file("${path.module}/${each.value}")
}

# Create Big Query Dataset for DOM table (FR HUB)
resource "google_bigquery_dataset" "d_fr_dom" {
  dataset_id                  = "d_crunch_fr_dom_${var.env}"
  delete_contents_on_destroy = true
  description                = "Dataset for Crunch FR DOM data"
  location                   = "EU"
  project                    = var.project
}

locals {
    fr_json_files_dom = fileset(path.module,"/FR/schema/dom/t_*.json")
}


# Create BigQuery DOM tables (FR HUB)
resource "google_bigquery_table" "FR_DOM_table" {
  for_each = local.fr_json_files_dom
  deletion_protection = false

  dataset_id = google_bigquery_dataset.d_fr_dom.dataset_id
  project = var.project
  table_id   = replace(replace(each.key, ".json", ""),"FR/schema/dom/","")
  schema     = file("${path.module}/${each.value}")
}

# Create Big Query Dataset for STG table (CESS HUB)
resource "google_bigquery_dataset" "d_cess_stg" {
  dataset_id                  = "d_crunch_cess_stg_${var.env}"
  delete_contents_on_destroy = true
  description                = "Dataset for Crunch CESS STG data"
  location                   = "EU"
  project                    = var.project
}

locals {
    cess_json_files_stg = fileset(path.module,"/CESS/schema/stg/t_*.json")
}

# Create BigQuery STG tables (CESS HUB)
resource "google_bigquery_table" "CESS_STG_table" {
  for_each = local.cess_json_files_stg
  deletion_protection = false

  dataset_id = google_bigquery_dataset.d_cess_stg.dataset_id
  project = var.project
  table_id   = replace(replace(each.key, ".json", ""),"CESS/schema/stg/","")
  schema     = file("${path.module}/${each.value}")
}

# Create Big Query Dataset for DOM table (CESS HUB)
resource "google_bigquery_dataset" "d_cess_dom" {
  dataset_id                  = "d_crunch_cess_dom_${var.env}"
  delete_contents_on_destroy = true
  description                = "Dataset for Crunch CESS DOM data"
  location                   = "EU"
  project                    = var.project
}

locals {
    cess_json_files_dom = fileset(path.module,"/CESS/schema/dom/t_*.json")
}


# Create BigQuery DOM tables (CESS HUB)
resource "google_bigquery_table" "CESS_DOM_table" {
  for_each = local.cess_json_files_dom
  deletion_protection = false

  dataset_id = google_bigquery_dataset.d_cess_dom.dataset_id
  project = var.project
  table_id   = replace(replace(each.key, ".json", ""),"CESS/schema/dom/","")
  schema     = file("${path.module}/${each.value}")
}


# Create Big Query Dataset for STG table (BNL HUB)
resource "google_bigquery_dataset" "d_bnl_stg" {
  dataset_id                  = "d_crunch_bnl_stg_${var.env}"
  delete_contents_on_destroy = true
  description                = "Dataset for Crunch BNL STG data"
  location                   = "EU"
  project                    = var.project
}

locals {
    bnl_json_files_stg = fileset(path.module,"/BNL/schema/stg/t_*.json")
}

# Create BigQuery STG tables (BNL HUB)
resource "google_bigquery_table" "BNL_STG_table" {
  for_each = local.bnl_json_files_stg
  deletion_protection = false

  dataset_id = google_bigquery_dataset.d_bnl_stg.dataset_id
  project = var.project
  table_id   = replace(replace(each.key, ".json", ""),"BNL/schema/stg/","")
  schema     = file("${path.module}/${each.value}")
}

# Create Big Query Dataset for DOM table (BNL HUB)
resource "google_bigquery_dataset" "d_bnl_dom" {
  dataset_id                  = "d_crunch_bnl_dom_${var.env}"
  delete_contents_on_destroy = true
  description                = "Dataset for Crunch BNL DOM data"
  location                   = "EU"
  project                    = var.project
}

locals {
    bnl_json_files_dom = fileset(path.module,"/BNL/schema/dom/t_*.json")
}


# Create BigQuery DOM tables (BNL HUB)
resource "google_bigquery_table" "BNL_DOM_table" {
  for_each = local.bnl_json_files_dom
  deletion_protection = false

  dataset_id = google_bigquery_dataset.d_bnl_dom.dataset_id
  project = var.project
  table_id   = replace(replace(each.key, ".json", ""),"BNL/schema/dom/","")
  schema     = file("${path.module}/${each.value}")
}



data "google_iam_policy" "dataviewer" {
  binding {
    role = "roles/bigquery.dataViewer"
    members = [
      "group:EMEA-GCP-EMEA-GB-BusinessKU@loreal.com",
    ]
  }
}

resource "google_bigquery_table_iam_policy" "policy" {
  project = google_bigquery_table.t_audit.project
  dataset_id = google_bigquery_table.t_audit.dataset_id
  table_id = google_bigquery_table.t_audit.table_id
  policy_data = data.google_iam_policy.dataviewer.policy_data
}

# resource "google_bigquery_table_iam_member" "dataeditor" {
#   project = google_bigquery_table.t_audit.project
#   dataset_id = google_bigquery_table.t_audit.dataset_id
#   table_id = google_bigquery_table.t_audit.table_id
#   role = "roles/bigquery.dataEditor"
#   member = "group:EMEA-GCP-CRUNCH@loreal.com"
# }

# Big Query External Table to be created


resource "google_bigquery_table" "t_exception" {
  deletion_protection = false
  dataset_id = google_bigquery_dataset.d_crunch_audit.dataset_id
  project    = var.project 
  table_id   = "t_exception"

  external_data_configuration {    
    autodetect    = false
    source_format = "CSV"
    ignore_unknown_values = false
    max_bad_records = 0    
    schema = "[{\"name\":\"exception_email\",\"type\":\"STRING\"}]"

    csv_options {
      field_delimiter = "#"
      quote = "\"" 
      skip_leading_rows = 1
      allow_jagged_rows = false
      allow_quoted_newlines = false
    }

    source_uris = [
      "gs://crunch-gcs-config-eu-${var.env}/exception.csv",
    ]
  }
}

resource "google_bigquery_table" "t_ba_information" {
  deletion_protection = false
  dataset_id = google_bigquery_dataset.d_crunch_audit.dataset_id
  project    = var.project 
  table_id   = "t_ba_information"

  external_data_configuration {
    autodetect    = false
    source_format = "CSV"
    ignore_unknown_values = false
    max_bad_records = 0    
    schema = "[{\"name\":\"hub\",\"type\":\"STRING\"},{\"name\":\"division_retailer_channel\",\"type\":\"STRING\"},{\"name\":\"ba_email\",\"type\":\"STRING\"},{\"name\":\"ba_name\",\"type\":\"STRING\"},{\"name\":\"day_of_delivery\",\"type\":\"STRING\"},{\"name\":\"running_dates\",\"type\":\"STRING\"},{\"name\":\"file_frequency\",\"type\":\"STRING\"},{\"name\":\"expected_file_count\",\"type\":\"INTEGER\"},{\"name\":\"input_file_type\",\"type\":\"STRING\"}]"

    csv_options {
      quote = "\"" 
      skip_leading_rows = 1
      allow_jagged_rows = false
      allow_quoted_newlines = false
    }

    source_uris = [
      "gs://crunch-gcs-config-eu-${var.env}/config_ref_index_view.csv",
    ]
  }
}

resource "google_bigquery_table" "v_web_monitoring" {
  deletion_protection = false
  dataset_id = google_bigquery_dataset.d_crunch_audit.dataset_id
  project    = var.project 
  table_id   = "v_web_monitoring"

  view {
    query = <<EOF
    SELECT
    run_id,
  upload_date,
  hub,
  division,
  retailer,
  channel,
  period,
  begindate,
  enddate,
  status,
  failure_reason,
  input_files,
  output_filename,
  incident_id,
  sys_id,
  ba_email,
  ba_email_with_exception,
  ba_name,
  day_of_delivery,
  running_dates,
  file_frequency
FROM (
  SELECT
    a.run_id,
    a.processed_timestamp AS upload_date,
    a.hub_name AS hub,
    SPLIT(a.division_retailer_channel, '_')[
  SAFE_OFFSET
    (0)] AS division,
    SPLIT(a.division_retailer_channel, '_')[
  SAFE_OFFSET
    (1)] AS retailer,
    SPLIT(a.division_retailer_channel, '_')[
  SAFE_OFFSET
    (2)] AS channel,
    a.begindate_enddate AS period,
    case when IFNULL(a.begindate_enddate,"") in ("NA","") 
      then current_date()
      else COALESCE(SAFE.PARSE_DATE('%Y%m%d', SPLIT(a.begindate_enddate,"_")[SAFE_OFFSET(0)]), current_date()) end AS begindate,
    case when IFNULL(a.begindate_enddate,"") in ("NA","") 
          then  current_date() 
          else COALESCE(SAFE.PARSE_DATE('%Y%m%d', SPLIT(a.begindate_enddate,"_")[SAFE_OFFSET(1)]), current_date()) end AS enddate,
    a.status,
    a.failure_reason,
    a.input_files,
    a.output_filename,
    IFNULL(a.incident_id,'') AS incident_id,
    IFNULL(a.sys_id,'') AS sys_id,
    IFNULL(b.ba_email,'') AS ba_email,
    CONCAT(IFNULL(b.ba_email,''),',',e.exception_email) AS ba_email_with_exception,
    IFNULL(b.ba_name,'') AS ba_name,
    IFNULL(b.day_of_delivery,'') AS day_of_delivery,
    IFNULL(b.running_dates,'') AS running_dates,
    IFNULL(b.file_frequency,'') AS file_frequency,
    ROW_NUMBER() OVER(PARTITION BY input_files ORDER BY processed_timestamp DESC) r
  FROM
  `${google_bigquery_table.t_audit.project}.${google_bigquery_table.t_audit.dataset_id}.${google_bigquery_table.t_audit.table_id}` a
JOIN (
  SELECT
    exception_email
  FROM
    `${google_bigquery_table.t_exception.project}.${google_bigquery_table.t_exception.dataset_id}.${google_bigquery_table.t_exception.table_id}`) e
ON
  1=1
LEFT OUTER JOIN
  `${google_bigquery_table.t_ba_information.project}.${google_bigquery_table.t_ba_information.dataset_id}.${google_bigquery_table.t_ba_information.table_id}` b
ON
    a.hub_name = b.hub
    AND a.division_retailer_channel = b.division_retailer_channel)
WHERE r=1
  EOF  
  use_legacy_sql = false
  }
  
}
