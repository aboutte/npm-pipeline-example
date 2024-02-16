
resource "duplocloud_aws_lambda_function" "app" {

  tenant_id   = local.tenant_id
  name        = "demo"
  description = "Sample function that shows using AWS Secrets Manager"

  package_type = "Image"
  image_uri    = "813590939111.dkr.ecr.us-west-2.amazonaws.com/frontend:lambda"

  image_config {
    command           = ["echo", "hello world", "DB=$(aws --region us-west-2 secretsmanager get-secret-value --secret-id duploservices-app01-database)", "echo $DB"]
    working_directory = "/"
  }

  tracing_config {
    mode = "PassThrough"
  }

  timeout     = 60
  memory_size = 512
}
