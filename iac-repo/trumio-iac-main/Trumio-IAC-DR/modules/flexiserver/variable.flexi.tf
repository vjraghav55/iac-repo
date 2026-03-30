variable "flexible_server_pvt_dns_name" {
  description = "Name of the Private DNS zone for the MySQL Flexible Server"
}

variable "flexible_server_rg_name" {
  description = "Resource group name for the MySQL Flexible Server"
}

variable "flexible_server_pvt_dns_vlink" {
  description = "Name of the Private DNS zone virtual network link for the MySQL Flexible Server"
}

variable "flexible_server_vnet_id" {
  description = "ID of the virtual network where the MySQL Flexible Server is deployed"
}

variable "flexible_server_location" {
  description = "Location for the MySQL Flexible Server"
}

variable "flexible_server_name" {
  description = "Name of the MySQL Flexible Server"
}

variable "admin_login" {
  description = "Administrator login for the MySQL Flexible Server"
}

variable "admin_password" {
  description = "Administrator password for the MySQL Flexible Server"
}

variable "flexible_server_subnet_id" {
  description = "ID of the subnet where the MySQL Flexible Server is deployed"
}

variable "sku_name" {
  description = "SKU name for the MySQL Flexible Server"
}

variable "mysql_version" {
  description = "MySQL version for the MySQL Flexible Server"
}

variable "db_name" {
  description = "Name of the database on the MySQL Flexible Server"
}
