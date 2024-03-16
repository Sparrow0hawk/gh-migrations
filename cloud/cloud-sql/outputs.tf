output "connection_name" {
  value = google_sql_database_instance.main.connection_name
}

output "private_key" {
  value     = google_service_account_key.proxy_user_private_key.private_key
  sensitive = true
}

output "password" {
  value     = google_sql_user.migration.password
  sensitive = true
}
