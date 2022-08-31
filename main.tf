module "cloudrun" {
  source                = "./modules/cloudrun"
  sa_name               = "run-invoker-1"
  cloudrun_service_name = "build-failure-handler-auto-1"
  project               = "${var.project}"
  image_url             = "<Enter Image url>" 
}

module "pubsub" {
  source            = "./modules/pubsub"
  topic_name        = "cloud-builds"
  subscription_name = "run-subscription"
  sa_email          = module.cloudrun.sa_email
  sa_role           = "roles/run.invoker"
  location          = "${var.location}"
  project_id        = "${var.project}"
  service_url       = module.cloudrun.service_url
  depends_on = [
    module.cloudrun
  ]
}
