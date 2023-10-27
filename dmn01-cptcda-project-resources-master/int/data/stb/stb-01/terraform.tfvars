
template  = {
  repo    = "workstream-data--template"
  path    = "stb"
  version = "v9.19.0"
}
################################################################################
# ****** Below values are for reference only. Actual values may differ. ****** #
################################################################################
#
## random_suffix : random string used for resource suffix
## project_id: Service project id where storage bucket needs to be created
## region : Available region. Currently "europe-west2" is only supported
## bucket_name : Storage bucket name. after bucket creation, random_suffix will be appended with name
## storage_class: available storage class is regional
## troux_id : Troux id of project
## cost_centre : Cost center for project
## owner : Owner of the resource
## environment : Use environment identifier. Available options are [ int | int | tst | pre | prd ]
## versioning : bucket versioning value [true | false], true allows the data to be restored.
## dataclassification : storage data classification, available options ["public", "limited", "highly-confidential", "confidential"]
random_suffix      = false
project_id         = "dmn01-cptcda-int-01-8c7c"
region             = "europe-west2"
bucket_name        = "dmn01-cda-int-01-stb-euwe2-soidplanding-01"
troux_id           = "dmn01-troux-id-cptcda"
cost_centre        = "413555"
owner              = "scott-anthony"
dataclassification = "confidential"
storage_class      = "regional"
environment        = "int"
versioning         = true

labels = {
  "cmdb_appid"     = "al16776"
}

//Setting up notification on file creation YG: DCS4-424PubSubEvent
bucket_notifications = {
  notification-one = {
    topic = "projects/dmn01-cptcda-int-01-8c7c/topics/cards-soi-internal-orch",
    event_types = ["OBJECT_FINALIZE"]
  }
}
//The below rule will match objects updated with Age 10 day and the current storage class is Regional then it will set the Storage class to COLDLINE
//It will delete all the object updated with Age 20 days and the current storage class is COLDLINE(Minimum age to keep in coldline is 90 days)
// Age is calculated based on the object updated/created time
lifecycle_rules = [
  {
    action = {
      type = "Delete"
    }
    condition = {
      age        = "2"
      with_state = "ANY"
      matches_storage_class= ["regional"]
    }
  }
]

iam_binding = {
  "roles/storage.objectAdmin" = [
     "serviceAccount:svc-stb-fth-objmgr@sbs-fth-int-01-716d.iam.gserviceaccount.com"
  ]
  "roles/storage.objectViewer" = []
  "roles/storage.admin" = ["group:gg_dmn01-cptcda-int_dataeng@e.lloydsbanking.com",
    "serviceAccount:svc-cpt-orchestrator-ms-user@dmn01-cptcda-int-01-8c7c.iam.gserviceaccount.com",
    "serviceAccount:svc-cpt-curation-ms-user@dmn01-cptcda-int-01-8c7c.iam.gserviceaccount.com",
    "serviceAccount:svc-cpt-ingestion-ms-user@dmn01-cptcda-int-01-8c7c.iam.gserviceaccount.com"]
}

kms_project_id = "dmn01-cptkms-int-01-5577"
kms_key_ring   = "krs-kms-dmn01-cptkms-euwe2-stb"
kms_crypto_key = "keyhsm-kms-dmn01-cptkms-euwe2-stb"
