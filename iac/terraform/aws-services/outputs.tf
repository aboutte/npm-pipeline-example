
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

output "ecr_repository_url" {
  value       = duplocloud_aws_ecr_repository.frontend.repository_url
  description = "The URL of the frontend ECR repository"
}
