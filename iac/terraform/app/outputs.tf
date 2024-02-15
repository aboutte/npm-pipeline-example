
output "url" {
  value       = "${local.tenant_id}.${var.base_domain}"
  description = "URL for accessing the frontend"
}

