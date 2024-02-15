
output "s3_search_fullname" {
  value       = duplocloud_s3_bucket.search.fullname
  description = "The full name of the S3 bucket."
}
output "s3_search_arn" {
  value       = duplocloud_s3_bucket.search.arn
  description = "The ARN of the S3 bucket."
}

output "region" {
  value       = local.region
  description = "The AWS Region for the Tenant"
}
