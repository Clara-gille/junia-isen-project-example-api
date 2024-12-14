output "vnet_id" {
  description = "The ID of the Virtual Network."
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_id_app_service" {
  description = "The ID of the Webapp subnet."
  value       = azurerm_subnet.subnet_app_service.id
}

output "subnet_id_db" {
  description = "The ID of the database subnet."
  value       = azurerm_subnet.subnet_db.id
}

output "subnet_id_app_gateway" {
  description = "The ID of the third subnet."
  value       = azurerm_subnet.subnet_app_gateway.id
}