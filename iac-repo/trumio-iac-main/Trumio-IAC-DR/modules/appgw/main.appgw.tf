resource "azurerm_application_gateway" "appgw" {
  name                = var.app_gw_name
  resource_group_name = var.app_gw_rg_name
  location            = var.app_gw_location

  sku {
    name     = var.app_gw_sku_name
    tier     = var.app_gw_sku_tier
    capacity = 1
  }

  gateway_ip_configuration {
    name      = var.app_gw_ip_config_name
    subnet_id = var.app_gw_subnet_id
  }

  identity {
    type                    = "UserAssigned"
    identity_ids            = var.app_gw_user_identity_id
  }
  frontend_port {
    name = "80"
    port = 80
  }

  frontend_port {
    name = "443"
    port = 443
  }

  dynamic "waf_configuration" {
    for_each = var.waf_configuration
    content {
      enabled          = waf_configuration.value.enabled
      firewall_mode    = waf_configuration.value.firewall_mode
      rule_set_version = waf_configuration.value.rule_set_version
    }
  }

  frontend_ip_configuration {
    name                 = var.app_gw_frontend_ip_name
    public_ip_address_id = var.app_gw_ip_address_id
  }


  dynamic "backend_address_pool" {
    for_each = var.backend_address_pool
    content {
      name = backend_address_pool.value.name
      ip_addresses = backend_address_pool.value.ip_addresses

    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name                   = backend_http_settings.value.name 
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      port                   = backend_http_settings.value.port 
      protocol               = backend_http_settings.value.protocol 
      request_timeout        = backend_http_settings.value.request_timeout
      pick_host_name_from_backend_address = true 
    }
  }

  ssl_certificate {
    name                = var.ssl_certificate_name
     data               = "${filebase64("trumio_ai.pfx")}"
    password            = "trumio@sys"
  }

  dynamic "http_listener" {
    for_each = var.http_listener
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = var.app_gw_frontend_ip_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      host_name                      = lookup(http_listener.value, "host_name", null)
      ssl_certificate_name           = lookup(http_listener.value, "ssl_certificate_name", null)

    
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rule
    content {
      name                       = request_routing_rule.value.name
      priority                   = request_routing_rule.value.priority
      rule_type                  = request_routing_rule.value.rule_type
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name 
    }
  }

  dynamic "probe" {
    for_each = var.probes
    content{
      name                  = probe.value.name
      protocol              = probe.value.protocol
      path                  = probe.value.path
      interval              = probe.value.interval
      timeout               = probe.value.timeout
      unhealthy_threshold   = probe.value.unhealthy_threshold 
      pick_host_name_from_backend_http_settings = true
    }
  }

}
