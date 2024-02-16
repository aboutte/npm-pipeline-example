
resource "duplocloud_k8s_cron_job" "queue" {
  tenant_id = local.tenant_id
  metadata {
    name = "queue-processor"
  }
  spec {
    job_template {
      spec {
        template {
          spec {
            restart_policy = "Never"
            container {
              name              = "scheduler"
              image             = "busybox:latest"
              image_pull_policy = "Always"
              command = ["/bin/sh", "-c", "date; echo Hello from the Kubernetes cluster; echo the database url is: $DATABASE_URL"]
              

              env {
                name  = "DUPLO"
                value = "true"
              }


              env {
                name  = "DATABASE_URL"
                value_from {
                    secret_key_ref {
                        key = "DATABASE_URL"
                        name = "database"
                    }
                }
              }
              env {
                name  = "DATABASE_USERNAME"
                value_from {
                    secret_key_ref {
                        key = "DATABASE_USERNAME"
                        name = "database"
                    }
                }
              }
              env {
                name  = "DATABASE_PASSWORD"
                value_from {
                    secret_key_ref {
                        key = "DATABASE_PASSWORD"
                        name = "database"
                    }
                }
              }



            }
          }
        }
      }
    }
    schedule                      = var.queue_schedule
    failed_jobs_history_limit     = 2
    successful_jobs_history_limit = 2
  }
  lifecycle {
    ignore_changes = [
      spec[0].job_template[0].spec[0].template[0].spec[0].container[0].image
    ]
  }
}

