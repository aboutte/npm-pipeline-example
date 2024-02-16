
resource "duplocloud_duplo_service" "frontend" {
  tenant_id                            = local.tenant_id
  name                                 = "frontend"
  replicas                             = var.replica_count
  lb_synced_deployment                 = false
  cloud_creds_from_k8s_service_account = false
  is_daemonset                         = false
  is_unique_k8s_node_required = true
  agent_platform                       = 7
  cloud                                = 0
  other_docker_config = jsonencode({
  "Volumes" : [
          {
            # Define the CSI volume for the secret we're mounting as a raw json file.  
            "Name" : "database",
            "Csi" : {
              "driver" : "secrets-store.csi.k8s.io",
              "readOnly" : true,
              "VolumeAttributes" : {
                "secretProviderClass" : duplocloud_k8_secret_provider_class.database.name
              }
            }
          },

          # Define the CSI volume for the env var example
          { "Name" : "database",
            "Csi" : {
              "driver" : "secrets-store.csi.k8s.io",
              "readOnly" : true,
              "volumeAttributes" : {
                "secretProviderClass" : duplocloud_k8_secret_provider_class.database.name
              }
            }
          }
        ]
      "VolumesMounts" : [
        {
          "Name" : "databasevolume",
          "MountPath" : "/mnt/fulljsonsecret",
          "readOnly" : true
        },

        # This is the mount for the env var example.  Note that you MUST do the mount 
        # before you can use the secret as an env var.
        # The mount triggers the CSI driver to create the K8s secret, 
        # which is then available for use as an env var
        # In this example we didn't specify an objectAlias for the 
        # secretProviderClass so the file will be mounted as 
        # /mnt/fieldsenvvar/duploservices-${tenant_name}-demo-secret"
        # (the name of the secret).  It will have the full text of the secret in json format
        # It will also create files based on the jmespath expression we provided. 
        # They will be named after the objectAlias we provided:
        # file /mnt/fieldsenvvar/MYFIRSTSECRETENVVAR will have contents S0M3S3cretV@Lue 
        # and /mnt/fieldsenvvar/MYSECONDENVVAR will have contents An0th3rS3cretV@Lue
        # We will also get a secret named fields-from-secret-manager with this data (decoded here)
        #data:
        #  MYFIRSTSECRETENVVAR: S0M3S3cretV@Lue
        #  MYSECONDSECRETENVVAR: An0th3rS3cretV@Lue

        {
          "Name" : "database",
          "MountPath" : "/mnt/fieldsenvvar",
          "readOnly" : true
        }
      ],
"EnvFrom" : [
        {
          "SecretRef" : {
            "name" : duplocloud_k8_secret_provider_class.database.secret_object[0].name
          }
        }
      ]
    "Env" : [
      # {
      #   "name" : "DB_URL",
      #   "valueFrom" : {
      #     "secretKeyRef" : {
      #       "key" : "DB_URL",
      #       "name" : "database"
      #     }
      #   }
      # },
      # {
      #   "name" : "DB_USERNAME",
      #   "valueFrom" : {
      #     "secretKeyRef" : {
      #       "key" : "DB_USERNAME",
      #       "name" : "database"
      #     }
      #   }
      # },
      # {
      #   "name" : "DB_PASSWORD",
      #   "valueFrom" : {
      #     "secretKeyRef" : {
      #       "key" : "DB_PASSWORD",
      #       "name" : "database"
      #     }
      #   }
      # },
      {
        "name" : "INTEGRATION_API_KEY",
        "valueFrom" : {
          "secretKeyRef" : {
            "key" : "integration_api_key",
            "name" : "integration"
          }
        }
      },
      {
        "Name" : "DUPLO",
        "Value" : "true"
      }
    ]
    }
  )
  docker_image = var.svc_frontend_docker_image
  volumes = jsonencode([
    {
      "Name" : "data",
      "Path" : "/data",
      "Spec" : {
        "ConfigMap" : {
          "Name" : "frontend"
        }
      }
    }
    ]
  )
  lifecycle {
    ignore_changes = [
      docker_image
    ]
  }
}


resource "duplocloud_duplo_service_params" "myservice" {
  tenant_id = local.tenant_id

  replication_controller_name = duplocloud_duplo_service_lbconfigs.frontend_config.replication_controller_name
  dns_prfx                    = terraform.workspace
  drop_invalid_headers        = true
  enable_access_logs          = true
  http_to_https_redirect      = true
}

resource "duplocloud_duplo_service_lbconfigs" "frontend_config" {
  tenant_id                   = duplocloud_duplo_service.frontend.tenant_id
  replication_controller_name = duplocloud_duplo_service.frontend.name
  
  lbconfigs {
    certificate_arn = data.duplocloud_plan_certificates.certs.certificates[0].arn
    lb_type          = 1
    is_native        = false
    is_internal      = false
    port             = 3000
    external_port    = 443
    protocol         = "http"
    health_check_url = "/"
  }
}


resource "duplocloud_k8_config_map" "frontend" {
  tenant_id = local.tenant_id

  name = "frontend"

  data = jsonencode({ foo = "bar2" })
}
