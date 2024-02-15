
resource "duplocloud_aws_ecr_repository" "test-ecr" {
  tenant_id                 = local.tenant_id
  name                      = "frontend"
  enable_scan_image_on_push = true
  enable_tag_immutability   = true
}
