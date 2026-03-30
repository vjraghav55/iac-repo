# Private DNS zones within Azure DNS
resource "azurerm_private_dns_zone" "flexible_server" {
  name                = var.flexible_server_pvt_dns_name
  resource_group_name = var.flexible_server_rg_name
}

# Enables you to manage Private DNS zone Virtual Network Links
resource "azurerm_private_dns_zone_virtual_network_link" "flexible_server" {
  name                  = var.flexible_server_pvt_dns_vlink
  resource_group_name   = var.flexible_server_rg_name
  private_dns_zone_name = var.flexible_server_pvt_dns_name
  virtual_network_id    = var.flexible_server_vnet_id
  depends_on            = [azurerm_private_dns_zone.flexible_server]
}


# Manages the MySQL Flexible Server
resource "azurerm_mysql_flexible_server" "flexible_server" {
  location                     = var.flexible_server_location
  name                         = var.flexible_server_name
  resource_group_name          = var.flexible_server_rg_name
  administrator_login          = var.admin_login
  administrator_password       = var.admin_password
  backup_retention_days        = 15
  delegated_subnet_id          = var.flexible_server_subnet_id
  private_dns_zone_id          = azurerm_private_dns_zone.flexible_server.id
  sku_name                     = var.sku_name
  version                      = var.mysql_version
  zone                         = "1"

  storage {
    iops    = 360
    size_gb = 20
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.flexible_server]
}

# MySQL Flexible Server Database
resource "azurerm_mysql_flexible_database" "mysqldb" {
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
  name                = var.db_name
  resource_group_name = var.flexible_server_rg_name
  server_name         = azurerm_mysql_flexible_server.flexible_server.name
  depends_on          = [azurerm_mysql_flexible_server.flexible_server]
}