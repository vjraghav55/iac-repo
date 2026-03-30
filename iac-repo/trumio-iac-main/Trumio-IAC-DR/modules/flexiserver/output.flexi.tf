output "mysql_server_name" {
  value = azurerm_mysql_flexible_server.flexible_server.name
}

output "mysql_server_private_dns_zone_id" {
  value = azurerm_private_dns_zone.flexible_server.id
}

output "mysql_database_name" {
  value = azurerm_mysql_flexible_database.mysqldb.name
}
