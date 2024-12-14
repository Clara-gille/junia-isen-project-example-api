output "vnet_id" {
  description = "The ID of the Virtual Network."
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_id_app_service" {
  description = "The ID of the App Service subnet."
  value       = azurerm_subnet.subnet_app_service.id
}

output "subnet_id_db" {
  description = "The ID of the Database subnet."
  value       = azurerm_subnet.subnet_db.id
}

output "subnet_id_app_gateway" {
  value = azurerm_subnet.subnet_app_gateway.id
}