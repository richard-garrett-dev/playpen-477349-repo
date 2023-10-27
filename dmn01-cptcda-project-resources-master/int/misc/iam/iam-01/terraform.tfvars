
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
project_id = "dmn01-cptcda-int-01-8c7c"
project_permissions = {
}
project_iam_conditions = {
}
remote_project_permissions = {
}
workload_identity = {
}
workload_identity_na = {
}
serviceaccount_user = {
}

