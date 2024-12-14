resource "azurerm_virtual_network" "vnet" {
  name                = "${var.random_id}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet_app_service" {
  name                = "subnet-app-service-${var.random_id}"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes    = ["10.0.1.0/24"]
  delegation {
    name = "delegation-app-service-${var.random_id}"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "subnet_db" {
  name                = "subnet-db-${var.random_id}"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes    = ["10.0.2.0/24"]
  service_endpoints = ["Microsoft.Storage"]
  delegation {
    name = "delegation-db-${var.random_id}"
    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}


resource "azurerm_subnet" "subnet_app_gateway" {
  name                = "subnet-app-gateway-${var.random_id}"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes    = ["10.0.3.0/24"]
}


# Règle pour NSG de l'App Service
resource "azurerm_network_security_group" "nsg-application" {
  name                = "nsg-application-${var.random_id}"
  resource_group_name = var.resource_group_name
  location            = var.location

  security_rule {
    name                       = "Allow_From_App_Gateway"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5000"
    source_address_prefix      = "10.0.3.0/24"
    destination_address_prefix = "10.0.1.0/24"
  }
}

# Règle pour NSG de la base de données (si la base est utilisée directement par le Gateway)
resource "azurerm_network_security_group" "nsg-database" {
  name                = "nsg-database-${var.random_id}"
  resource_group_name = var.resource_group_name
  location            = var.location

  security_rule {
    name                       = "Allow_From_App_Gateway"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.3.0/24"
    destination_address_prefix = "10.0.2.0/24"
  }
}