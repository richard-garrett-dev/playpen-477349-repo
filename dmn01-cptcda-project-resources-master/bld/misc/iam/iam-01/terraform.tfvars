
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
project_id = "dmn01-cptcda-bld-01-b1d3"
project_permissions = {
# service account
"svc-cpt-auth-curation-ms-user"        = []
}
project_iam_conditions = {
}
remote_project_permissions = {
 "svc-gke-local-resourcecreator@dmn01-cptcda-bld-01-b1d3.iam.gserviceaccount.com" = ["roles/container.admin","roles/storage.admin"]
  "svc-gke-resprov-dmn01-prd@mgmt-ple-prd-83f7.iam.gserviceaccount.com" = ["roles/pubsub.admin"]
  "svc-kcl-jenk-cpt-deployer@dmn01-cptctl-bld-01-42e6.iam.gserviceaccount.com" = ["roles/container.admin", "roles/storage.admin"]
  "svc-gke-local-resourcecreator@dmn01-cptctl-bld-01-42e6.iam.gserviceaccount.com" = ["roles/container.admin","roles/storage.admin"]
  "svc-gke-ple-dynatrace@mgmt-ple-bld-81ed.iam.gserviceaccount.com" = ["organizations/233526418605/roles/custom.svc.dynatrace.gcpservicemonitoring"]
}
workload_identity = {
  ## Service: cpt-soi-card-auth-curation-service
  "svc-cpt-auth-curation-ms-user" = {
    "namespaces"        = ["ns-kcl-dmn01-cptcda-auth-curation"]
    "source_project_id" = "dmn01-cptcda-bld-01-b1d3"
    "target_project_id" = "dmn01-cptcda-bld-01-b1d3"
    "iam_svc_account"   = "svc-cpt-auth-curation-ms-user"
    "kubernetes_sa"     = "sa-cpt-auth-curation-ms-user"
  }
}
workload_identity_na = {
}
serviceaccount_user = {
}

