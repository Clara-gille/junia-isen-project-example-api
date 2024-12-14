resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = "${var.random_id}.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link" {
  name                  = "${var.random_id}-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_postgresql_flexible_server" "postgresql-server"{
    name                = "postgresql-server-${var.random_id}"
    resource_group_name = var.resource_group_name
    location            = var.location
    zone = 1
    sku_name            = "B_Standard_B1ms"
    storage_mb          = 32768
    administrator_login = var.username_db
    administrator_password = var.password_db
    version = "16"
    public_network_access_enabled = false
    delegated_subnet_id = var.subnet_id_db
    private_dns_zone_id = azurerm_private_dns_zone.private_dns_zone.id
}

resource "azurerm_postgresql_flexible_server_database" "postgresql_database" {
    name                = "shop"
    server_id           = azurerm_postgresql_flexible_server.postgresql-server.id
    charset             = "UTF8"
}