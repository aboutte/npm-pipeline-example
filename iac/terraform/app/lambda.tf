
resource "duplocloud_aws_lambda_function" "app" {

  tenant_id   = local.tenant_id
  name        = "demo"
  description = "Sample function that shows using AWS Secrets Manager"

  package_type = "Image"
  image_uri    = "813590939111.dkr.ecr.us-west-2.amazonaws.com/frontend:lambda4"


  tracing_config {
    mode = "PassThrough"
  }

  timeout     = 60
  memory_size = 512
}
