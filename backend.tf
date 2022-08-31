
##
terraform {
  backend "gcs" {
    bucket = "data-project-dev-314214-tfstate"
    prefix = "env/dev"
    impersonate_service_account = "cloud-saude-terraform@data-project-dev-314214.iam.gserviceaccount.com"
  }
}
