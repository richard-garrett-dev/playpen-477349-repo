
template  = {
  repo    = "workstream-data--template"
  path    = "psb"
  version = "v9.19.0"
}
################################################################################
# ****** Below values are for reference only. Actual values may differ. ****** #
################################################################################
#
## project_id : The project ID to manage the Pub/Sub resources
## topic: List of Pub/Sub topics to create
## allowed_persistence_regions: Policy constraining the set of Google Cloud Platform regions where messages published to the topic may be stored.
## service_account_name : Service account for pubsub to be created
## create_service_account : Service account to be created through module, value is set to be true for now
## ack_deadline_seconds: The maximum time after a subscriber receives a message before the subscriber should acknowledge the message. Max is 600, Minimum is 10
## retain_acked_messages: True / False
## message_retention_duration: Optional. If defined it cannot be more than 7 days (604800s) or less than 10 minutes (600s). Defaults to 7 days
## ttl: Specifies the 'time-to-live' duration for an associated resource. The resource expires if it is not active for a period of ttl. If ttl is not set, the associated resource never expires.
## subscriber_account_ids: List of service account IDs that are allowed to consume from the subscription.
## viewer_account_ids: List of account IDs that are allowed to view the subscription
## publisher_account_ids: List of service account IDs that are allowed to publish to the topic(s).
## topic_labels: A map of labels to assign to the Pub/Sub topic
## subscriptions_labels: A map of labels to assign to the Pub/Sub topic
## subscription_conf: Subscription Configurations -- https://github.com/lbg-gcp-foundation/workstream-data--template/blob/a546d07669baf4450536f31a87e5755510a1bd11/psb/variables.tf#L91
# dataclassification :
##                    see https://github.com/hashicorp/terraform/issues/2847, there's an experimental validation functionality coming in 0.12.20
##                    valid_dataclassification    = ["public", "limited", "highly-confidential", "confidential"]
## Full list of vars located here: https://github.com/lbg-gcp-foundation/workstream-data--template/blob/master/psb/variables.tf

project_id                 = "dmn01-cptcda-bld-01-b1d3"
kms_project_id             = "dmn01-cptkms-bld-01-988c"
kms_region                 = "europe-west2"
kms_key_ring               = "krs-kms-dmn01-cptkms-euwe2-pst"
kms_crypto_key             = "keyhsm-kms-dmn01-cptkms-euwe2-pst"
retain_acked_messages      = false
ack_deadline_seconds       = "300s"
message_retention_duration = "3600s"
ttl                        = ""
dataclassification         = "confidential"
cost_centre                = "413560"
env                        = "bld"
cmdb_appid                 = "al16776"

publisher_account_ids = [
  "serviceAccount:svc-cpt-orchestrator-ms-user@dmn01-cptcda-bld-01-b1d3.iam.gserviceaccount.com",
  "serviceAccount:svc-cpt-curation-ms-user@dmn01-cptcda-bld-01-b1d3.iam.gserviceaccount.com",
  "serviceAccount:svc-cpt-ingestion-ms-user@dmn01-cptcda-bld-01-b1d3.iam.gserviceaccount.com",
  "serviceAccount:service-125115394228@gs-project-accounts.iam.gserviceaccount.com",
  "group:gg_dmn01-cptcda-bld_dataeng@e.lloydsbanking.com"
#  "serviceAccount:svc-gke-resprov-tfci-tst@mgmt-ple-tst-254e.iam.gserviceaccount.com",
]

subscriber_account_ids = [
  "serviceAccount:svc-cpt-orchestrator-ms-user@dmn01-cptcda-bld-01-b1d3.iam.gserviceaccount.com",
  "serviceAccount:svc-cpt-curation-ms-user@dmn01-cptcda-bld-01-b1d3.iam.gserviceaccount.com",
  "serviceAccount:svc-cpt-ingestion-ms-user@dmn01-cptcda-bld-01-b1d3.iam.gserviceaccount.com",
  "serviceAccount:service-125115394228@gs-project-accounts.iam.gserviceaccount.com",
  "group:gg_dmn01-cptcda-bld_dataeng@e.lloydsbanking.com"
#  "serviceAccount:svc-gke-resprov-tfci-tst@mgmt-ple-tst-254e.iam.gserviceaccount.com",
]

viewer_account_ids = [
#  "serviceAccount:svc-gke-resprov-tfci-tst@mgmt-ple-tst-254e.iam.gserviceaccount.com",
]

#list of topics that will be created
topic = [
  "cards-soi-internal-status",
  "cards-soi-internal-orch",
  "cards-soi-internal-file-ingestion",
  "cards-soi-internal-curation"
]
topic_labels = {
  "owner"              = "scott-anthony"
  "troux_id"           = "dmn01-troux-id-cptcda"
  "cost_centre"        = "413560"
  "dataclassification" = "limited" # this has to be confidential or highly confidential for volume encryption
  "cmdb_appid"         = "al16776"
}

subscriptions_labels = {
  cost_centre = "413560"
  owner       = "scott-anthony"
  cmdb_appid  = "al16776"
  troux_id    = "dmn01-troux-id-cptcda"
  env         = "bld"
}

subscription_conf = {
  subscription1 = {
    subscription_name     = "cards-soi-internal-status_sub",
    topic_name            = "cards-soi-internal-status",
    enable_deadletter     = "false",
    dead_letter_topic     = "",
    max_delivery_attempts = 10,
    subscribers           = [],
    viewers               = []
  },
  subscription2 = {
    subscription_name     = "cards-soi-internal-orch_sub",
    topic_name            = "cards-soi-internal-orch",
    enable_deadletter     = "false",
    dead_letter_topic     = "",
    max_delivery_attempts = 10,
    subscribers           = [],
    viewers               = []
  },
  subscription3 = {
    subscription_name     = "cards-soi-internal-file-ingestion_sub",
    topic_name            = "cards-soi-internal-file-ingestion",
    enable_deadletter     = "false",
    dead_letter_topic     = "",
    max_delivery_attempts = 10,
    subscribers           = [],
    viewers               = []
  },
  subscription4 = {
    subscription_name     = "cards-soi-internal-curation_sub",
    topic_name            = "cards-soi-internal-curation",
    enable_deadletter     = "false",
    dead_letter_topic     = "",
    max_delivery_attempts = 10,
    subscribers           = [],
    viewers               = []
  }

}

