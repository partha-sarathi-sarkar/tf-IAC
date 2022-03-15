resource "azurerm_resource_group" "net" {
  name     = var.rg-name
  location = var.location
}

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY VIRTUAL NETWORK
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_virtual_network" "net" {
  name                = var.vnet-name
  location            = azurerm_resource_group.net.location
  resource_group_name = var.rg-name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = [var.dns_ip_01, var.dns_ip_02]

  depends_on = [
    azurerm_resource_group.net
  ]

  tags = {
    Environment = var.environment
  }
}

resource "azurerm_subnet" "net" {
  name                 = var.subnet-name
  resource_group_name  = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.subnet_prefix]
  depends_on = [
    azurerm_virtual_network.net
  ]
}


# ---------------------------------------------------------------------------------------------------------------------
# For public and public networking please copy paste code from public&privatenetworking
# ---------------------------------------------------------------------------------------------------------------------