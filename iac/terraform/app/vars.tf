
variable "svc_frontend_docker_image" {
  default = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${region}.amazonaws.com/${terraform.workspace}-frontend:main"
  description = "Default docker image that will be deployed.  New versions will be pushed out via GitHub Action pipeline."
  type    = string
}

variable "replica_count" {
  type    = number
  description = "The number of replicas to run in the k8s environment"
  default = 1
}

variable "integration_api_key" {
  default   = ""
  description = "This is dummy secret that can be set via GitHub Action Secret.  Refer to the Deployment section of the README for more details."
  type      = string
  sensitive = true
}

variable "queue_schedule" {
  default = "*/5 * * * *"
  description = "Frequency to run the k8s cronjob"
  type    = string
}
