
variable "svc_frontend_docker_image" {
  default = "813590939111.dkr.ecr.us-west-2.amazonaws.com/frontend:main"
  type    = string
}


variable "replica_count" {
  type = number
  default = 1
}

variable "base_domain" {
  default = "salesdemo-apps.duplocloud.net."
  type    = string
}

variable "integration_api_key" {
  default = ""
  type    = string
  sensitive = true
}

variable "queue_schedule" {
  default = "*/5 * * * *"
  type    = string
}
