# Infra-Build-Notification-RUN
Terraform to build required infra to support Handling Build Failure in Automated way
## **Contents**
1. [Scope](#Scope)
2. [Overview](#Overview)
3. [Prerequisites ?](#Prerequisites?)
    * [Impersonation ](#Impersonation)
    * [remote_backened](#remote_backened)
    * [cloud_run_setup](#cloud_run_setup)

## Scope <a name="Scope"></a>
This document explains the neccessary steps required to create infra in GCP to support Handling of [Handling of Build Failure in Automated way](https://github.com/addy3352/HandlingDeploymentFailure_AutomatedWay_GCP_CICD).
## Overview <a name="Overview"></a>
The Solution will direct Build notifications to go to Pub-SUB topic where subscription will be created to push “Failure notification” to flask application (web application) hosted on Cloud Run. The web application will extract build_id from the failure notification and then extract trigger name and last successful commit_id for the trigger. Based on the trigger name , the web application will revert respective git branches to the extracted commit_id. The Changes in git branches will subsequently trigger build to roll back all changes to previous successful version. As shown above, system is restored to last successful version which is commit:2.

![]
### Create Required Infra in GCP:
Terrafrom is used to build required infra to support the automation. Following will be created using Terraform:
1. Cloud Run
2. Pub Sub Topic & Subscription
3. Service Account and required Permission
Deployment through terraform has been done using impersonation. So there is no need to share service account keys which makes this solution very secure.

## Prerequisites <a name="Prerequisites"></a>

### Impersonation <a name="Impersonation"></a>
create an impersonated service account and give token creator role to cloud build service account on impersonated service account.Give impersonated service account required permission to create, and manage cloud build, Run and Cloud Storage

### remote_backened <a name="remote_backened"></a>
Create GCP storage bucket- “${var.project}-tfstate” with versioning on (versioning is recommended not mandatory )

### cloud_run_setup <a name="cloud_run_setup"></a>

1. Create repository in Artifact registry: gcloud artifacts repositories create <repo_name>— repository-format=docker — location=us-central1 — description=”Docker repository”
2. Image creation with Dockerfile -Run the command in the directory where Dockerfile is located for web application.
   gcloud builds submit — region us-central1 — tag us-central1-docker.pkg.dev/<project_id>/<repo_name>/<image_name>:latest
3. 
