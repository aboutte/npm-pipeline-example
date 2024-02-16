
resource "duplocloud_k8_secret" "secret" {
  tenant_id   = local.tenant_id
  secret_name = "database"
  secret_type = "Opaque"
  secret_data = jsonencode({
    "db_url" : local.db_url
    "db_username" : local.db_username
    "db_password" : local.db_password
    }
  )
}

resource "duplocloud_k8_secret" "integration" {
  tenant_id   = local.tenant_id
  secret_name = "integration"
  secret_type = "Opaque"
  secret_data = jsonencode({
    "integration_api_key" : var.integration_api_key
    }
  )
}

resource "duplocloud_tenant_secret" "mysecret2" {
  tenant_id = local.tenant_id

  # The full name will be:  duploservices-myapp-myjson
  name_suffix = "myjson"

  data = jsonencode({ foo = "bar" })
}