
resource "duplocloud_k8_secret" "secret" {
  tenant_id   = local.tenant_id
  secret_name = "demo"
  secret_type = "Opaque"
  secret_data = jsonencode({
    "key1" : "bar"
    "key2" : "baz"
    }
  )
}
