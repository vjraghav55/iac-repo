
resource "azurerm_cdn_frontdoor_profile" "front_door" {
  name                = var.front_door_name
  resource_group_name = var.front_door_rg_name
  sku_name            = var.front_door_sku_name
}

resource "azurerm_cdn_frontdoor_endpoint" "endpoint" {
  name                     = var.front_door_endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.front_door.id
}

resource "azurerm_cdn_frontdoor_origin_group" "origin_group" {
  name                     = var.front_door_origin_group_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.front_door.id
  session_affinity_enabled = false

  load_balancing {
    sample_size                 = 4
    successful_samples_required = 3
    additional_latency_in_milliseconds = 50
  }

  health_probe {
    path                = "/"
    request_type        = "HEAD"
    protocol            = "Https"
    interval_in_seconds = 100
  }
}

resource "azurerm_cdn_frontdoor_origin" "origin" {
  name                          = var.front_door_origin_name
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.origin_group.id
  enabled                        = true
  host_name                      = var.storage_account_static
  origin_host_header             = var.storage_account_static
  http_port                      = 80
  https_port                     = 443
  priority                       = 1
  weight                         = 1000
  certificate_name_check_enabled = true
}

resource "azurerm_cdn_frontdoor_route" "route" {
  name                          = var.front_door_route_name
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.origin_group.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.origin.id]

  supported_protocols    = ["Http", "Https"]
  patterns_to_match      = ["/*"]
  forwarding_protocol    = "HttpsOnly"
  link_to_default_domain = true
  https_redirect_enabled = true
  
  #cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.contoso.id, azurerm_cdn_frontdoor_custom_domain.fabrikam.id]
  #link_to_default_domain          = false

  cache {
    #compression_enabled           = true
    query_string_caching_behavior = "UseQueryString"
  }
}
