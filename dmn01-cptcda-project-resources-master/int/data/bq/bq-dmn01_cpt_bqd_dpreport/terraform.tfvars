
template  = {
  repo    = "workstream-data--template"
  path    = "bq"
  version = "v9.19.0"
}
################################################################################
# ****** Below values are for reference only. Actual values may differ. ****** #
################################################################################
#

## project_id = The ID of the project where this big query dataset will be created
## dataset_id = A unique ID for this dataset, without the project name. e.g. gke_logs_dataset
## location = (Optional) The geographic location where the dataset should reside, default = europe-west2
## default_table_expiration_ms = (Optional) The default lifetime of all tables in the dataset, in milliseconds. The minimum value is 3600000 milliseconds (one hour), default = null
## default_partition_expiration_ms = (Optional) The default lifetime of all partitions in the dataset, in milliseconds. The minimum value is 3600000 milliseconds (one hour), default = null
## friendly_name = (Optional) A descriptive name for the dataset following ep_[a-z]{3}_(ide|bld|int|pre|prd|tst)_[a-z]{3}_[a-z0-9]{2,3}_[a-z0-9-]{0,30}, default = null
## description = (Optional) A user-friendly description of the dataset, default     = null
## delete_contents_on_destroy = (Optional) If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present, default = true
## labels = The labels associated with this dataset.
## access_config = The desired configuration for access
## kms_key_ring   = (Required) kms key ring
## kms_location   = (Required) key ring location
## kms_project_id = (Required) Project that hold the kms keys
## kms_crypto_key = (Required) the key to use to encrypt/decrypt secrets
## tables = Table names, set up {} if no table required
## views = View names, set up [] if no view required 
project_id                 = "dmn01-cptcda-int-01-8c7c"
dataset_id                 = "dmn01_cpt_bqd_dpreport"
friendly_name              = "A BigQuery dataset for reporting"
location                   = "europe-west2"
description                = "SOI Reporting BigQuery Dataset"
delete_contents_on_destroy = true
deletion_protection        = false

access_config = {
  "dataOwner" = {
    role           = "roles/bigquery.dataOwner"
    group_by_email = "gg_dmn01-cptcda-int_dataeng@e.lloydsbanking.com"
  },
  "dataEditor" = {
    role          = "roles/bigquery.dataEditor"
    user_by_email = "svc-cpt-ingestion-ms-user@dmn01-cptcda-int-01-8c7c.iam.gserviceaccount.com"
  },
  "dataEditor" = {
    role          = "roles/bigquery.dataEditor"
    user_by_email = "svc-cpt-curation-ms-user@dmn01-cptcda-int-01-8c7c.iam.gserviceaccount.com"
  },
  "jobUser" = {
    role           = "roles/bigquery.dataViewer"
    group_by_email = "gg_dmn01-cptcda-int_queryjobuser@e.lloydsbanking.com"
  }
}

labels = {
  "troux_id"           = "dmn01-troux-id-cptcda"
  "cost_centre"        = "413560"
  "owner"              = "scott-anthony"
  "dataclassification" = "confidential"
  "cmdb_appid"         = "al16776"
}

kms_key_ring   = "krs-kms-dmn01-cptkms-euwe2-bqd"
kms_location   = "europe-west2"
kms_project_id = "dmn01-cptkms-int-01-5577"
kms_crypto_key = "keyhsm-kms-dmn01-cptkms-euwe2-bqd"
schema_dir     = "."

tables = {
  "test_table_1" = {
    kms_crypto_key = "keyhsm-kms-dmn01-cptkms-euwe2-bqt"
    kms_project_id = "dmn01-cptkms-int-01-5577",
    kms_location   = "europe-west2",
    kms_key_ring   = "krs-kms-dmn01-cptkms-euwe2-bqt"
  }
}

views = []

