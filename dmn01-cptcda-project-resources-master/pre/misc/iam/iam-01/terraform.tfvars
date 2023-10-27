
template  = {
  repo    = "workstream-misc--template"
  path    = "iam"
  version = "v3.7.4"
}
################################################################################
# ****** Below values are for reference only. Actual values may differ. ****** #
################################################################################
#
## Manage IAM permissions for service accounts and groups
#
## project_id : Service project id for IAM needs to be changed
## project_permissions : Service account for project which needs to be created 
##                       and mapped against the roles
## project_iam_conditions : IAM Conditions for roles gratted to a speficic service account
## remote_project_permissions : Remote service account should be already created,
##                              as only roles can be applied
## remote_project_project_iam_conditions : IAM Conditions for roles gratted to a remote project speficic service account
## workload_identity:  is the recommended way to access Google Cloud services from within GKE.
## workload_identity_na : Non autoritative work load identity mapping, specific usecase for multitenancy cluster
project_id = "dmn01-cptcda-pre-01-b039"
project_permissions = {
  # service account
  "svc-gke-secret-sync"                 = ["roles/container.developer"]
  "svc-cpt-orchestrator-ms-user"        = ["roles/pubsub.admin","roles/bigquery.jobUser","roles/bigquery.dataEditor","roles/iam.workloadIdentityUser","roles/container.admin"]
  "svc-cpt-curation-ms-user"            = ["roles/pubsub.admin","roles/bigquery.jobUser","roles/bigquery.dataEditor","roles/bigquery.metadataViewer","roles/storage.admin","roles/container.admin"]
  "svc-cpt-ingestion-ms-user"            = ["roles/pubsub.admin","roles/bigquery.jobUser","roles/bigquery.dataEditor","roles/bigquery.metadataViewer","roles/storage.admin","roles/container.admin"]
}
project_iam_conditions = {
}
remote_project_permissions = {
  "svc-gke-resprov-dmn01-prd@mgmt-ple-prd-83f7.iam.gserviceaccount.com"            = ["roles/pubsub.admin"]
}
workload_identity = {
  "svc-gke-secret-sync" = {
    "namespaces"    = ["ns-kcl-helm-secret-sync"]
    "kubernetes_sa" = "sa-svc-gke-secret-sync"
  }
    ## Service: cpt-soi-orchestration-service
  "svc-cpt-orchestrator-ms-user" = {
    "namespaces"        = ["ns-kcl-dmn01-cptcda-orchestrator"]
    "source_project_id" = "dmn01-cptcda-pre-01-b039"
    "target_project_id" = "dmn01-cptcda-pre-01-b039"
    "iam_svc_account"   = "svc-cpt-orchestrator-ms-user"
    "kubernetes_sa"     = "sa-cpt-orchestrator-ms-user"
  }
  ## Service: cpt-soi-curation-service
  "svc-cpt-curation-ms-user" = {
    "namespaces"        = ["ns-kcl-dmn01-cptcda-curation"]
    "source_project_id" = "dmn01-cptcda-pre-01-b039"
    "target_project_id" = "dmn01-cptcda-pre-01-b039"
    "iam_svc_account"   = "svc-cpt-curation-ms-user"
    "kubernetes_sa"     = "sa-cpt-curation-ms-user"
  }
  ## Service: cpt-soi-ingestion-service
  "svc-cpt-ingestion-ms-user" = {
    "namespaces"        = ["ns-kcl-dmn01-cptcda-ingestion"]
    "source_project_id" = "dmn01-cptcda-pre-01-b039"
    "target_project_id" = "dmn01-cptcda-pre-01-b039"
    "iam_svc_account"   = "svc-cpt-ingestion-ms-user"
    "kubernetes_sa"     = "sa-cpt-ingestion-ms-user"
  }
}
workload_identity_na = {
}
serviceaccount_user = {
}

