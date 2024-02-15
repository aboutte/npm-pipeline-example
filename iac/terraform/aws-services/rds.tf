resource "random_password" "password" {
  length  = 16
  numeric = true
  special = false
}

resource "duplocloud_rds_instance" "db" {
  tenant_id      = local.tenant_id
  name           = "app"
  engine         = 0                          
  engine_version = "8.0.32"
  size           = "db.t3.medium"

  master_username = "app-admin"
  master_password = random_password.password.result

  encrypt_storage = true
}
