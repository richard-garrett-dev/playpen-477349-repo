
template  = {
  repo    = "workstream-kcl--template"
  path    = "kcl/gke"
  version = "v17.27.2"
  ipam = true
}

resource_labels = {
  "owner"              = "scott-anthony"
  "troux_id"           = "dmn01-troux-id-cptcda"
  "cost_centre"        = "413560"
  "dataclassification" = "highly-confidential" # this has to be confidential or highly confidential for volume encryption
  "cmdb_appid"         = "al16776"
  "spi_onboarding"      = "false"
  "valuestream"         = "dmn01"
  "workstream"          = "cptcda"
  "cluster_group"       = "cda"
  "region"              = "region-1"
  "environment"         = "bld-01"
  "app_onboarding_repo" = "dmn01-cpt-application-onboarding"
}

# project specific values
#
## host_project_id : A host project contains one or more Shared VPC networks. Modify project id ( not project name ) through which service project shares the VPC.
## service_project_id : Service project id for which resources are to be provision.
## cost_centre : Cost center for project
## network : VPC Network name
## subnetwork : Subnetwork name belonging to service project
## default_max_pods_per_node : Max pods a node can have in GKE cluster. Changing this once cluster is created will destroy and recreate. more details are available at : https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips
#
host_project_id    = "dmn01-hst-bld-ab15"
service_project_id = "dmn01-cptcda-bld-01-b1d3"
cost_centre        = "404676"
network            = "dmn01-bld-hst-cnw"
subnetwork         = "cptcda-csn-euwe2-kcl-01-bld-01"
environment        = "bld-01"

fleet_project_id = "dmn01-ins-bld-ce6a"
deploy_acm = true
sync_repo_image_tag = "v1-deny"

dns_zone_filter = "dmn01-bld"
dns_identifier = "cptcda"

# GKE cluster specific values (this archetype is using GKE version as 1.13.11-gke.14 with initial node count 1)
#
## name : GKE Cluster name following naming standard from https://ltmhedge.atlassian.net/wiki/x/AgqRGg
## node_pool_name : GKE node pool names following naming standard from https://ltmhedge.atlassian.net/wiki/x/AgqRGg
## description : GKE description
## machine_type : GKE nodes with specific compute type, more details are available at : https://cloud.google.com/compute/docs/machine-types#n1_standard_machine_types
## min_node_count : Minimum node count with which GKE would be provisioning
## max_node_count : Maximum node count with which GKE would be provisioning
## http_load_balancing : Flag for http load balancing option with GKE cluster
## master_authorized_networks_config : List of IPs to be part of master authorized network, display name is signifies related network name for remote project
name                = "dmn01-cptcda-bld-01-kcl-01-euwe2"
node_pool_name      = "dmn01-cptcda-bld-01-knp-01-euwe2"
description         = "MSA cluster for Card Platform Domain"   # fixed value changing this after creation will destroy and re-create cluster with all data lost
machine_type        = "n1-standard-8"
min_node_count      = 1   # ( per zone so 1 is 1X3=3  nodes across all zones)
max_node_count      = 20   # ( per zone so 4 is 4X3=12 nodes across all zones)
#  The selected release channel. Accepted values are:
#  UNSPECIFIED: Not set.
#  RAPID: Weekly upgrade cadence; Early testers and developers who requires new features.
#  REGULAR: Multiple per month upgrade cadence; Production users who need features not yet offered in the Stable channel.
#  STABLE: Every few months upgrade cadence; Production users who need stability above all else, and for whom frequent upgrades are too risky.
release_channel     = "STABLE" # Only allowed on TST / BLD environments and not in RTL
## IF release channel is specified below 2 values should be with in the supported versions for that release channel
## kubernetes_version : set below param when a cluster need to be created with specific version of master. The version should be in supported list.
#                       default latest is considered if not set
## kubernetes_node_pool_version : set below param when a cluster node pool need to be upgraded to certain version.
#                                 default latest is considered if not set
kubernetes_version           = "1.24.12-gke.1000"  # Refer to available versions at https://rtlviewer.mgmt-bld.oncp.dev/gke (opens on BLD env) - GCP updates these automatically to latest
kubernetes_node_pool_version = "1.24.12-gke.1000"  # Refer to available versions at https://rtlviewer.mgmt-bld.oncp.dev/gke (opens on BLD env)

## -------introduced in v6.6.0 of kcl template.
## enable_csi_driver - enabled by default. Whether this cluster should enable the Google Compute Engine Persistent Disk Container Storage Interface (CSI) Driver. Defaults to enabled; set false to disable.
enable_csi_driver = true # defaulted to true so optional to mention

## -------introduced in v6.11.0 kcl template
# Optional. Do not use vertical Pod autoscaling with Horizontal Pod autoscaling which is set by default as true
# Vertical Pod Autoscaling automatically adjusts the resources of pods controlled by it.
vertical_pod_autoscaling = false #https://cloud.google.com/kubernetes-engine/docs/concepts/verticalpodautoscaler

# Optional. Whether Intra-node visibility is enabled for this cluster. This makes same node pod to pod traffic visible for VPC network
enable_intranode_visibility = false #https://cloud.google.com/kubernetes-engine/docs/how-to/intranode-visibility

# Optional. taints are added only first time when node pool gets created. any updates will get ignored.
# taint = [{ "key" : "key1", "value" : "value1", "effect" : "PREFER_NO_SCHEDULE" }, { "key" : "key2", "value" : "value2", "effect" : "PREFER_NO_SCHEDULE" }]

#  Optional as defaults are set. Specify node upgrade settings to change how many nodes GKE attempts to upgrade at once. The number of nodes upgraded simultaneously is the sum of max_surge and max_unavailable. The maximum number of nodes upgraded simultaneously is limited to 20
#  max_surge - The number of additional nodes that can be added to the node pool during an upgrade. Increasing max_surge raises the number of nodes that can be upgraded simultaneously. Can be set to 0 or greater.
#  max_unavailable - The number of nodes that can be simultaneously unavailable during an upgrade. Increasing max_unavailable raises the number of nodes that can be upgraded in parallel. Can be set to 0 or greater.
#  see https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-upgrades?&_ga=2.214574228.-2045790325.1584615127#surge
upgrade_settings = { max_surge : 2, max_unavailable : 1 }

#  Optional - Whether the nodes will be automatically upgraded.
auto_upgrade = true    # set by default so node_pools version can be managed rather than auto upgrade when GCP upgrades masters automatically

http_load_balancing = false
## Master auth networks enable connectivity for approved management subnets and these should not be removed and additional subnets can be added as needed for istio usecases
## BLD ENV

master_authorized_networks_config = [{
  cidr_blocks = [
    {
      cidr_block   = "10.84.1.240/28"
      display_name = "vpn-csn-euwe2-ovpn"
    },
    {
      cidr_block   = "10.84.128.80/28"
      display_name = "vpn-csn-euwe1-ovpn"
    },
    {
      cidr_block   = "172.19.192.0/20"
      display_name = "ple-bld-euwe2-pods"
    },
    {
      cidr_block   = "172.28.112.0/20"
      display_name = "ple-bld-euwe1-pods"
    },
    {
      cidr_block   = "172.22.64.0/20"
      display_name = "cmp-csn-euwe2-kcl-01-pods"
    },
    {
      cidr_block   = "172.28.48.0/20"
      display_name = "cmp-csn-euwe1-kcl-01-pods"
    },
    {
      cidr_block   = "100.65.224.0/20"
      display_name = "cptctl-csn-euwe2-kcl-01-bld-01-pods"
    },
    {
      cidr_block   = "10.84.27.64/26"
      display_name = "cptctl-csn-euwe2-kcl-01-bld-01-node"
    },
  ],
}]

## database_encryption : By default, GKE encrypts customer content stored at rest, including Secrets. GKE handles and manages this default encryption for you without any additional action.
#                        Settings provides an additional layer of security for sensitive data, such as Secrets, stored in etcd.
#                        state - (Required) ENCRYPTED or DECRYPTED
#                        key_name - (Required) the key to use to encrypt/decrypt secrets. See the DatabaseEncryption definition for more information.
## additional_node_pools: This is optional feature, default is empty [] ; below is the example if a new node pool is to be created
## max_pods_per_node : Max pods a node can have in this additional node pool.

database_encryption = {
  state           = "ENCRYPTED",
  key_name        = "keyhsm-kms-dmn01-cptcda-ewe2-kcl-01",
  key_project_id  = "dmn01-cptkms-bld-01-988c",
  location        = "europe-west2",
  ring_name       = "krs-kms-dmn01-cptcda-ewe2-kcl-01"
}

## -------introduced in v6.0.0 for kcl.
## Volume Encryption - not mandatory if resource label dataclassfication is not confidential
## =================
## To achieve volumeencryption dataclassification has to be set to either confidential or highly-confidential.
## Once this label is set it is mandatory to supply kms key for volume encryption. any label other than confidential/highly confidential will not do encryption of volumes.
## Also ensure to add project svc account ("serviceAccount:service-projnumber@compute-system.iam.gserviceaccount.com" = ["roles/cloudkms.cryptoKeyEncrypterDecrypter"]) on the kms key.
## 4 encrypted storage classes are added to use with pvc out of which 2 are for regional replication. Node boot disks are also encrypted.
##
volume_encryption = { # this is mandatory if resource_labels.dataclassification = confidential or highly confidential
  state          = "ENCRYPTED",
  key_name       = "keyhsm-kms-dmn01-cptcda-ewe2-kcd-01",
  key_project_id = "dmn01-cptkms-bld-01-988c",
  location       = "europe-west2",
  ring_name      = "krs-kms-dmn01-cptcda-ewe2-kcd-01"
}

additional_node_pools = []

# IPAM values for seed VM run using existing datastore
##   Follow below table for values of ipam_env and ipam_namespace. Please confirm the value of ipam_db_project_id with platoform team before execution
##
##   ----------------------------------------------------------------------------------------
##   | ipam_env       | ipam_namespace | ipam_endpoint_uri             | ipam_db_project_id |
##   | ---------------|--------------- |-------------------------------|---------------------
##   | Production     | RTL            | http://ipam.mgmt-tst.oncp.dev | mgmt-mds-tst-b7fd  |
##   | Build          | BUILD          | http://ipam.mgmt-bld.oncp.dev | mgmt-mds-prd-d5c3  |
##   | Integration    | RTL            | http://ipam.mgmt-prd.oncp.io  | mgmt-mds-prd-d5c3  |
##   | Pre-Production | RTL            | http://ipam.mgmt-prd.oncp.io  | mgmt-mds-prd-d5c3  |
##   | Production     | RTL            | http://ipam.mgmt-prd.oncp.io  | mgmt-mds-prd-d5c3  |
##   ----------------------------------------------------------------------------------------
#
ipam_env           = "Build"
ipam_endpoint_uri  = "http://ipam.mgmt-bld.oncp.dev"
ipam_namespace     = "BUILD"
ipam_db_project_id = "mgmt-mds-prd-d5c3"


# Additional variables for services
#
## nexus_url : Nexus instance url - "nexus.mgmt-bld.oncp.dev" / "nexus.mgmt-prd.oncp.io"
## proxy_url : Squid proxy domain - "proxy.mgmt-bld.oncp.dev" / "proxy.mgmt-prd.oncp.io"
## proxy_port : Squid proxy port - 3128
## coredns_url : coredns endpoint for internal dns registration - "coredns.mgmt-bld.oncp.dev" / "coredns.mgmt-prd.oncp.io" 
## smtp_url : smtp endpoint for email notification
## domain : Domain suffix for services to provision with
##        : oncp.dev - BLD
##        : oncp.group - INT/PRD
##        : oncp.io - PRD
nexus_url           = "nexus.mgmt-bld.oncp.dev"
proxy_url           = "ep.threatpulse.net"
proxy_port          = "80"
coredns_url         = "coredns.mgmt-bld.oncp.dev"
smtp_url            = "smtprelay.mgmt-bld.oncp.dev"
domain              = "oncp.dev"

## istio_secret_bucket : This param should be working in conjenction with flag 'enable_istio'. Bucket where encrypted istio certs are stored, the path for rootCA and certs might be different.
##                        Refer https://github.com/lbg-gcp-foundation/istio-selfsigned-certs/blob/master/README.md.
##                        Allowed values are mgmt-ple-tst-stb-eu-istio-certs for tst env, mgmt-ple-bld-stb-eu-istio-certs for bld env and mgmt-ple-prd-stb-eu-istio-certs for rest of the environments
## istio_secret_path: This param must be working in conjenction with flag 'enable_istio'. Istio certs secret path refers to the place within which ca certs are to be present.
##                    Refer https://github.com/lbg-gcp-foundation/istio-selfsigned-certs/blob/master/README.md.
##                    Allowed values are based on the folder structure of env file.
##                    mgmt:
##                      - tst
##                    <value-stream>:
##                      - <env>
##
enable_istio         = false
istio_secret_bucket  = "mgmt-ple-bld-stb-eu-istio-certs"
istio_secret_path    = "dmn01-bld-01"

## resource_labels :  Mandatory resource labels for resource compliance.
##                    see https://github.com/hashicorp/terraform/issues/2847, there's an experimental validation functionality coming in 0.12.20
##                    valid_dataclassification    = ["public", "limited", "highly-confidential", "confidential"]
##    - Label keys and values must conform to the following format:
##        * Keys and values cannot be longer than 63 characters each.
##        * Keys and values can only contain:
##        * Lowercase letters
##        * Numeric characters
##        * Underscores
##        * Hyphens
##        * International characters are allowed.
##        * Label keys must start with a lowercase letter.
##        * Label keys cannot be empty.
