variable "front_door_name" {
  description = "The name of the Azure CDN Front Door profile."
  type        = string
}

variable "front_door_rg_name" {
  description = "The name of the resource group where the Azure CDN Front Door profile will be created."
  type        = string
}

variable "front_door_sku_name" {
  description = "The SKU name of the Azure CDN Front Door profile."
  type        = string
}

variable "front_door_endpoint_name" {
  description = "The name of the Azure CDN Front Door endpoint."
  type        = string
}

variable "front_door_origin_group_name" {
  description = "The name of the Azure CDN Front Door origin group."
  type        = string
}

variable "front_door_origin_name" {
  description = "The name of the Azure CDN Front Door origin."
  type        = string
}

variable "front_door_route_name" {
  description = "The name of the Azure CDN Front Door route."
  type        = string
}

variable "storage_account_static" {
  description = "The Azure Storage Account object."
}
