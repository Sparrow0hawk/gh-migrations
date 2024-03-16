output "connection_name" {
  description = "Cloud SQL instance connection name"
  value       = module.cloud_sql.connection_name
}

output "password" {
  description = "Google SQL database password"
  value       = module.cloud_sql.password
  sensitive   = true
}

output "cloud_sql_proxy_private_key" {
  description = "Service account key for cloud sql auth proxy"
  value       = module.cloud_sql.private_key
  sensitive   = true
}

output "github_action_private_key" {
  description = "Service account key for github action service account"
  value       = module.github_action.private_key
  sensitive   = true
}
