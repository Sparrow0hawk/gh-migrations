resource "google_project_service" "sql_admin" {
  project = var.project
  service = "sqladmin.googleapis.com"
}

resource "google_sql_database_instance" "main" {
  name                = "gh-migration"
  region              = var.location
  project             = var.project
  deletion_protection = false

  database_version = "POSTGRES_15"

  settings {
    tier                  = "db-f1-micro"
    connector_enforcement = "REQUIRED"

    ip_configuration {
      ipv4_enabled = true
      require_ssl  = true
      ssl_mode     = "TRUSTED_CLIENT_CERTIFICATE_REQUIRED"
    }
  }
}

resource "google_sql_database" "gh_migration" {
  name    = "gh-migration"
  project = var.project

  instance = google_sql_database_instance.main.name
}

resource "random_password" "migration" {
  length = 20
}

resource "google_sql_user" "migration" {
  name    = "migration"
  project = var.project

  instance = google_sql_database_instance.main.name
  password = random_password.migration.result
}

resource "google_secret_manager_secret" "gh_migration_database_password" {
  secret_id = "gh-migration-database-password"
  project   = var.project

  replication {
    auto {
    }
  }
}

resource "google_secret_manager_secret_version" "capital_schemes_database_password_version" {
  secret      = google_secret_manager_secret.gh_migration_database_password.id
  secret_data = random_password.migration.result
}

resource "google_service_account" "proxy_user" {
  account_id   = "proxy-user"
  display_name = "Cloud SQL Auth proxy service account"
}

resource "google_project_iam_member" "main" {
  member  = "serviceAccount:${google_service_account.proxy_user.email}"
  role    = "roles/cloudsql.client"
  project = var.project
}

resource "google_service_account_key" "proxy_user_private_key" {
  service_account_id = google_service_account.proxy_user.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}
