
variable "svc_frontend_docker_image" {
  default = "813590939111.dkr.ecr.us-west-2.amazonaws.com/frontend:latest"
  type    = string
}


variable "replica_count" {
  type = number
  default = 1
}

# TODO: this is kind of a hack.  I updated the apply.sh wrapper script to generate this value using TF_VAR_tenant
variable "tenant" {
  type = string
}

variable "base_domain" {
  default = "salesdemo-apps.duplocloud.net."
  type    = string
}


variable "queue_schedule" {
  default = "*/5 * * * *"
  type    = string
}
