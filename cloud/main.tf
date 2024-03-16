terraform {
  backend "local" {}
}

provider "google" {
  project = local.project
}

locals {
  location = "europe-west1"
  project  = "sparrow0hawk-gh-migration"
}

module "secret_manager" {
  source  = "./secret-manager"
  project = local.project
}

module "cloud_sql" {
  source     = "./cloud-sql"
  project    = local.project
  location   = local.location
  depends_on = [module.secret_manager]
}

module "github_action" {
  source  = "./github-action"
  project = local.project
}
