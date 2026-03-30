variable "app_gw_name" {
  description = "Name of the Application Gateway"
  type        = string
}

variable "app_gw_rg_name" {
  description = "Resource group name for the Application Gateway"
  type        = string
}

variable "app_gw_location" {
  description = "Location for the Application Gateway"
  type        = string
}

variable "app_gw_sku_name" {
  description = "SKU name for the Application Gateway"
  type        = string
}

variable "app_gw_sku_tier" {
  description = "SKU tier for the Application Gateway"
  type        = string
}

variable "app_gw_ip_config_name" {
  description = "Name of IP configuration for the Application Gateway"
  type        = string
}

variable "app_gw_subnet_id" {
  description = "Subnet ID for the Application Gateway"
  type        = string
}

variable "app_gw_ip_address_id" {
  description = "Public IP Address ID for the Application Gateway"
  type        = string
}

# variable "app_gw_listener_ssl_cert_name" {
#   description = "SSL certificate name for Application Gateway listener"
#   type        = string
# }


# variable "app_gw_ssl_certificate_data" {
#   description = "SSL certificate data for the Application Gateway"
#   type        = string
# }

# variable "app_gw_ssl_certificate_password" {
#   description = "Password for the SSL certificate"
#   type        = string
# }

variable "app_gw_frontend_ip_name" {
  description = "Name for frontend"
  type        = string
}

# variable "app_gw_frontend_port_name" {
#   description = "Port for frontend"
#   type        = string
# }


variable "app_gw_user_identity_id" {
  description = "User-assigned identity ID for the Application Gateway"
  type        = list(string)
}

variable "waf_configuration" {
  type        = map(object({
    enabled          = bool
    firewall_mode    = string
    rule_set_version = string
  }))
  description = ""
}

variable "backend_address_pool" {
  description = "backend_address_pool block"
  type        = map(object({
    name = string
    ip_addresses = list(string)
  }))
}

variable "backend_http_settings" {
  description = "backend http settings block"
  type = map(object({
    name                  = string
    cookie_based_affinity = string
    port                  = number
    protocol              = string
    request_timeout       = number
  }))
}

variable "ssl_certificate_name" {
  type        = string
}

# variable "key_vault_secret_id" {
#   type        = string
# }

variable "http_listener" {
  description = "http listener block"
  type        = map(object({
    name      = string
    protocol  = string
    host_name = string
    frontend_port_name = string
    ssl_certificate_name  = string
  }))
}


variable "request_routing_rule" {
  description = "request routing rule block"
  type        = map(object({
    name                       = string
    priority                   = string
    rule_type                  = string
    http_listener_name         = string
    backend_address_pool_name  = string
    backend_http_settings_name = string
  }))
}

variable "probes" {
  description = "probe block"
  type        = map(object({
      name                  = string
      protocol              = string
      path                  = string
      interval              = number
      timeout               = number
      unhealthy_threshold   = number
  }))
}
