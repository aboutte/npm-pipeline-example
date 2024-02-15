
resource "duplocloud_duplo_service" "frontend" {
  tenant_id                            = local.tenant_id
  name                                 = "frontend"
  replicas                             = var.replica_count
  lb_synced_deployment                 = false
  cloud_creds_from_k8s_service_account = false
  http_to_https_redirect = true
  is_daemonset                         = false
  is_unique_k8s_node_required = true
  agent_platform                       = 7
  cloud                                = 0
  other_docker_config = jsonencode({
    "Env" : [
      {
        "Name" : "DUPLO",
        "Value" : "true"
      }
    ]
    }
  )
  docker_image = var.svc_frontend_docker_image
  lifecycle {
    ignore_changes = [
      docker_image
    ]
  }
}




resource "duplocloud_duplo_service_lbconfigs" "frontend_config" {
  tenant_id                   = duplocloud_duplo_service.frontend.tenant_id
  replication_controller_name = duplocloud_duplo_service.frontend.name
  # certificate_arn = 
  lbconfigs {
    lb_type          = 1
    is_native        = false
    is_internal      = false
    port             = 3000
    external_port    = 443
    protocol         = "http"
    health_check_url = "/"
  }
}

resource "duplocloud_aws_target_group_attributes" "askduplo_dev_listener_443_tg_attributes" {
  tenant_id        = local.tenant_id
  target_group_arn = duplocloud_aws_load_balancer_listener.askduplo_dev_listener_443.target_group_arn
  attribute {
    key   = "target_group_health.unhealthy_state_routing.minimum_healthy_targets.count"
    value = "1"
  }




  attribute {
    key   = "stickiness.lb_cookie.duration_seconds"
    value = "86400"
  }
  attribute {
    key   = "slow_start.duration_seconds"
    value = "0"
  }
  attribute {
    key   = "stickiness.app_cookie.duration_seconds"
    value = "86400"
  }
  attribute {
    key   = "target_group_health.dns_failover.minimum_healthy_targets.percentage"
    value = "off"
  }
  attribute {
    key   = "load_balancing.cross_zone.enabled"
    value = "use_load_balancer_configuration"
  }
  attribute {
    key   = "load_balancing.algorithm.type"
    value = "round_robin"
  }
}


resource "duplocloud_k8_config_map" "frontend" {
  tenant_id = local.tenant_id

  name = "frontend"

  data = jsonencode({ foo = "bar2" })
}
