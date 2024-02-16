
# Example using AWS SecretsManager secret that can be used by k8s (via k8s secret provider) and Lambda
resource "duplocloud_tenant_secret" "database" {
  tenant_id = local.tenant_id

  # The full name will be:  duploservices-myapp-myjson
  name_suffix = "database"

  data = jsonencode({
    "DB_URL" : local.db_url
    "DB_USERNAME" : local.db_username
    "DB_PASSWORD" : local.db_password
    })
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

resource "duplocloud_k8_secret_provider_class" "spc" {
  tenant_id       = local.tenant_id
  name            = "database"
  secret_provider = "aws"

  secret_object {
    name = "database"
    type = "Opaque"
    data {
      key         = "DB_URL"
      object_name = "DB_URL"
    }
    data {
      key         = "DB_USERNAME"
      object_name = "DB_USERNAME"
    }
    data {
      key         = "DB_PASSWORD"
      object_name = "DB_PASSWORD"
    }
  }

  parameters = yamlencode(
    [
      {
        "objectName" : "duploservices-dev02-database",
        "objectType" : "secretsmanager",
        "jmesPath" : [
          {
            "path" : "DB_URL",
            "objectAlias" : "DB_URL"
          },
          {
            "path" : "DB_USERNAME",
            "objectAlias" : "DB_USERNAME"
          },
          {
            "path" : "DB_PASSWORD",
            "objectAlias" : "DB_PASSWORD"
          }
        ]
      }
    ]
  )
}