data "aws_caller_identity" "current" {
}

data "duplocloud_tenant_aws_region" "current" {
  tenant_id = local.tenant_id
}

data "duplocloud_plan_certificate" "cert" {
  name = var.base_domain
  plan_id = data.duplocloud_tenant.tenant.plan_id
}

data "duplocloud_tenant" "tenant" {
  name = local.tenant_name
}


locals {
  tfstate_bucket = "duplo-tfstate-${data.aws_caller_identity.current.account_id}"
  region         = data.duplocloud_tenant_aws_region.current.aws_region
  tenant_id      = data.terraform_remote_state.tenant.outputs["tenant_id"] 
  tenant_name    = data.terraform_remote_state.tenant.outputs["tenant_name"]
}

data "terraform_remote_state" "tenant" {
  backend   = "s3"
  workspace = terraform.workspace
  config = {
    bucket               = local.tfstate_bucket
    workspace_key_prefix = "admin:"
    key                  = "tenant"
    region               = "us-west-2"
  }
}

data "terraform_remote_state" "aws-services" {
  backend   = "s3"
  workspace = terraform.workspace
  config = {
    bucket               = local.tfstate_bucket
    workspace_key_prefix = "tenant:"
    key                  = "aws-services"
    region               = "us-west-2"
  }
}
