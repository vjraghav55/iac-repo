output "frontdoor_profile_id" {
  value = azurerm_cdn_frontdoor_profile.front_door.id
}

output "frontdoor_endpoint_id" {
  value = azurerm_cdn_frontdoor_endpoint.endpoint.id
}

output "frontdoor_origin_group_id" {
  value = azurerm_cdn_frontdoor_origin_group.origin_group.id
}

output "frontdoor_origin_id" {
  value = azurerm_cdn_frontdoor_origin.origin.id
}

output "frontdoor_route_id" {
  value = azurerm_cdn_frontdoor_route.route.id
}

output "front_door_endpoint_hostname" {
  value = azurerm_cdn_frontdoor_endpoint.endpoint.host_name
}
