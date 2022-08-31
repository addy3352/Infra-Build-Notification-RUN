
##
terraform {
  backend "gcs" {
    bucket = "${var.project}-tfstate"
    prefix = "env/dev"
    impersonate_service_account = "enter impersonate service account email "
  }
}
