
resource "duplocloud_k8_secret" "secret" {
  tenant_id   = local.tenant_id
  secret_name = "database"
  secret_type = "Opaque"
  secret_data = jsonencode({
    "db_url" : "bar"
    "db_username" : local.db_password
    "db_password" : local.db_password
    }
  )
}
