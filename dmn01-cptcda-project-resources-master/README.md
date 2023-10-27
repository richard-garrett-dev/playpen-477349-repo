# workstream-project-resources
#
<img src="https://img.shields.io/badge/Code%20Classification-Internal-green" alt="code classification Internal">

- [workstream-project-resources](#workstream-project-resources)
    - [How to use this template](#how-to-use-this-template)
  - [Steps to create project specific repo](#steps-to-create-project-specific-repo)
  - [Archetype resources](#archetype-resources)
    - [Compute archetype](#compute-archetype)
    - [Data archetype](#data-archetype)
    - [KCL archetype](#kcl-archetype)
    - [Logging archetype](#logging-archetype)
    - [MISC archetype](#misc-archetype)
    - [Network archetype](#network-archetype)
    - [Security archetype](#security-archetype)
  - [Feature releases with archetype](#feature-releases-with-archetype)
  - [Contributors](#contributors)

### How to use this template

---

Idea behind creation of this repo is, the users should be worried only to maintain minimal set of configuration for creating resources in a gcp project & the code is maintained in archetype repositories for them. Every new project need some resources to be created. This repo stands as a template or reference repo to create project specific configuration repo. The jenkins job corresponding to project specific configuration repo will take care of clubbing the configuration with archetype and create the resources.

This repo has configuration corresponding to archetype of data, kcl and iam for each environment. Each archetype folder again have corresponding resource folders. The resource folders will have the configuration maintained in them.

## Steps to create project specific repo

---
1. [Click here](https://github.com/lbg-gcp-foundation/workstream-project-resources/generate) to generate repository for resource provisioning.

2. Provide new project repo name in format `<valuestream>-<workstream|project>-project-resources`. e.g. `mgmt-vpn-project-resources`, `eplus-pyt-project-resources`, `eplus-chl-project-resources`. Please ensure that the naming convention is as per the [standard](https://confluence.devops.lloydsbanking.com/display/PTE/Platform+Evolution+%7C+Design+Decisions+%7C+Naming+Conventions) 

3. Clone the newly created project for local development & follow branching structure for development. Cloned repository consists of multiple environment and different project resources e.g. data, kcl , iam etc. Each resource creation is driven by property file `terraform.tfvars` or `*yaml` configuration file, inside the resource folder.

4. You may keep the services only which are to be used. With progressive migration to different environments, the values can be changed and committed back.

5. `state_bucket.yaml` is available in each environment and should consist of project's bucket name where terraform state files are to be stored.

6. Modify the `terraform.tfvars` files with resource folders, to align it with your project. If there are dependency on certain resources which are not covered with archetype, reach out to [platform-team](mailto:LBG_GCP_PS_Team@publicissapient.com) or raise a [platform support ticket](https://jira.devops.lloydsbanking.com/browse/GPE). 

![platform-support-ticket](Platform-Support-Ticket.png?raw=true)

7. Update [README.md](README.md) to reflect correct name.

8. Rename [Jenkinsfile.resources](Jenkinsfile.resources) to `Jenkinsfile`.
   ```sh
   mv Jenkinsfile.resources Jenkinsfile
   ```

9. Delete `pipelines` folder as this is not required for project-resources repositories.
   ```sh
   rm -rf pipelines/
   ```

10. Make sure that you are always using master of [jenkins-sharedlib-terraform](https://github.com/lbg-gcp-foundation/jenkins-sharedlib-terraform/releases/) library.
    ```sh
    # Execute
    grep jenkins-sharedlib-terraform Jenkinsfile
   
    # Expected output
    @Library("jenkins-sharedlib-terraform") _
    ```

11. Configure `<valuestream>-<workstream|project>-project-resources` repository with jenkins as Github Organization job. https://confluence.devops.lloydsbanking.com/display/GPE/Platform+Pipeline+Standards

12. PR job will execute the plan and generate a release tag for git repository. Once the PR is merged the plan will be executed on bld environment to create a git release tag corresponding to bld environment.

    Any further release on RTL environments needs to follow the pattern of  `bld -> int -> pre -> prd`. This is driven by recent changes with [Release pipeline and controls](https://confluence.devops.lloydsbanking.com/display/GPE/Release+Pipeline+and+controls).

13. Jenkins job on `master` branch will prompt for environment selection and approval. It will then plan and apply terraform changes.

14. The same template can be used as reference if any new resources or archetype folders are to be added to existing project config repositories.

15. :information_source: When creating a new GKE cluster using the `workstream-kcl--template` 

    - Run firewall on the workstream hst project resources and respective mgmt-hst project resources need to be exectued for BLD and PRD environments as the default firewall rules do not allow egress and will fail with cluster bootstraping unless this is executed (run with force apply)
    - Run terraform.tvars with charts.yaml (both can be run at the same time)

    **Note**: fwl resource under misc template, needs to have a separate project named <valuestream>-hst-project-resources as the changes are applicable for host project within shared VPC.

16. Update the [CODEOWNERS](.github/CODEOWNERS) file **valuestreams can add platform-reviewers-<vs> github team for * rule and template_versions.yml**. Refer to github [teams link](https://github.com/orgs/lbg-gcp-foundation/teams/reviewers/teams) for available teams

## Archetype resources

---

This repository is a placeholder for different archetypes. Using the repo, one can deploy the services with below components.

### Compute archetype

```yaml
Repository:  workstream-compute--template
Service(s):
  - cas:  Chef automate server to run compliance and generate reports
  - ovpn: OpenVPN with SLDAP
  - pgs:  Postgress sql
```
### Data archetype

```yaml
Repository : workstream-data--template
Service(s):
  - bq: Big Query resources ( dataset, dataset iam )
  - dcl: Dataproc
  - psb: PubSub
  - rmt: Memory Store
  - spn: Spanner
  - sql: Cloud SQL
  - stb: Storage Bucket
  - btc: Big Table
```
### KCL archetype

```yaml
Repository: workstream-kcl--template
Service(s):
  - kcl: Google Kubernetes Cluster
```
### Logging archetype

```yaml
Repository:  workstream-logging--template
Service(s):
  - dsh: Dashboard & Charts
  - lbm: Log Based Metrics
  - lsk: Log sink using PubSub
  - met: Alert Metrics & Policies
  - lbq: Log sink using BigQuery 
```
### MISC archetype

```yaml
Repository:  workstream-misc--template
Service(s):
  - iam: IAM provision for project as well as remote account permission
  - frc: Firebase Application
  - pgs: [Planned for deprecation] Postgress sql
```
### Network archetype

```yaml
Repository:  workstream-network--template
Service(s):
  - cga: Google cloud external address with DNS record set
  - dfz: DNS Forwarding Zone
  - dnp: DNS Private Zone Peering - will help to resolve DNS between VPC's in different projects. Two way peering mgmt(prd) => eplus(prd) | eplus(prd) => mgmt(prd)
  - dpz: DNS Private Zone to create private hosted zone
  - drs: Domain Record Set supporting multiple [ "A" records for a given IP | "CNAME" records against a domain ]
  - drz: DNS Recursive Zone to create public hosted zone
  - fwl: Firewall provisioning with yaml based configuration
  - nat: NAT attachment to router
  - pdd: Peered DNS Domains
  - sip: Static IP
  - vpe: HA-VPN External Connection with Peer VPN Gateway
  - vpn: HA-VPN Internal Connection
```
### Security archetype

```yaml
Repository:  workstream-security--template
Service(s):
  - cap: Cloud armor policies resources which holds security configurations
  - kms: Cloud KMS keyring, key creation and service account permission
  - ssl: Security SSL policy, ability to control feature of SSL that a Google Cloud SSL proxy load balancer or external HTTP(S) load balancer negotiates with clients
```

## Feature releases with archetype

If any of the component changes with bug fixes, features or major changes, the repository would be updated with available parameters and tags with [template_versions.yaml](template_versions.yml) .

## Contributors

[Rana Nama](https://github.com/rananama2)

[Arvind Kumar](https://github.com/akumar-lbg)
