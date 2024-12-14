resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip-${var.random_id}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"  
}

locals {
  backend_address_pool_name      = "${var.random_id}-beap"
  frontend_port_name             = "${var.random_id}-feport"
  frontend_ip_configuration_name = "${var.random_id}-feip"
  http_settings_name             = "${var.random_id}-be-htst"
  listener_name                  = "${var.random_id}-httplstn"
  request_routing_rule_name      = "${var.random_id}-rqrt"
  redirect_configuration_name    = "${var.random_id}-rdrcfg"
}

resource "azurerm_application_gateway" "app_gateway" {
    name = "app-gateway-${var.random_id}"
    resource_group_name = var.resource_group_name
    location = var.location
    sku {
        name = "Standard_v2"
        tier = "Standard_v2"
        capacity = 2
    }
    gateway_ip_configuration {
        name = "app-gateway-ip-configuration-${var.random_id}"
        subnet_id = var.subnet_id_app_gateway
    }

    frontend_port {
        name = local.frontend_port_name
        port = 5000
    }

    frontend_ip_configuration {
        name = local.frontend_ip_configuration_name
        public_ip_address_id = azurerm_public_ip.public_ip.id
    }

    backend_address_pool {
        name = local.backend_address_pool_name
        fqdns = [var.app_service_host]
    }

    backend_http_settings {
        name = local.http_settings_name
        cookie_based_affinity = "Disabled"
        port = 5000
        path = "/"
        protocol = "Http"
        request_timeout = 2
    }

    http_listener {
        name = local.listener_name
        frontend_ip_configuration_name = local.frontend_ip_configuration_name
        frontend_port_name = local.frontend_port_name
        protocol = "Http"
    }

    request_routing_rule {
        name = local.request_routing_rule_name
        rule_type = "Basic"
        http_listener_name = local.listener_name
        backend_address_pool_name = local.backend_address_pool_name
        backend_http_settings_name = local.http_settings_name
        priority = 9
    }
}