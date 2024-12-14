# Virtual network to host subnets and resources
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.random_id}"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Subnet in the virtual network for the webapp (here 10.0.1.0)
resource "azurerm_subnet" "subnet_app_service" {
  name                  = "subnet-app-service-${var.random_id}"
  resource_group_name   = var.resource_group_name
  virtual_network_name  = azurerm_virtual_network.vnet.name
  address_prefixes      = ["10.0.1.0/24"]

  # Delegation of the subnet for specific purposes
  delegation {
    name      = "delegation-app-service-${var.random_id}"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# Second subnet for the database (here, 10.0.2.0)
resource "azurerm_subnet" "subnet_db" {
  name                  = "subnet-db-${var.random_id}"
  resource_group_name   = var.resource_group_name
  virtual_network_name  = azurerm_virtual_network.vnet.name
  address_prefixes      = ["10.0.2.0/24"]
  service_endpoints     = ["Microsoft.Storage"]

  # Delegation of the subnet for database purposes
  delegation {
    name      = "delegation-db-${var.random_id}"
    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

# Third subnet for other purposes (here 10.0.3.0)
resource "azurerm_subnet" "subnet_app_gateway" {
  name                  = "subnet-app-gateway-${var.random_id}"
  resource_group_name   = var.resource_group_name
  virtual_network_name  = azurerm_virtual_network.vnet.name
  address_prefixes      = ["10.0.3.0/24"]
}


# Security rule for the webapp to allow from the third subnet
resource "azurerm_network_security_group" "application-rule" {
  name                = "application-rule-${var.random_id}"
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

# Security rule for the database to allow from the third subnet
resource "azurerm_network_security_group" "database-rule" {
  name                = "database-rule-${var.random_id}"
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