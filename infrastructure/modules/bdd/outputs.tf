output "database_name" {
  value = azurerm_postgresql_flexible_server.postgresql-server.name
}

output "database_host" {
  value = azurerm_postgresql_flexible_server.postgresql-server.fqdn
}