# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY PRIVATE NETWORK INTERFACE
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_network_interface" "net01" {
  name                = "nic-private-${var.postfix}"
  location            = azurerm_resource_group.net.location
  resource_group_name = azurerm_resource_group.net.name

  ip_configuration {
    name                          = "terratestconfiguration1"
    subnet_id                     = azurerm_subnet.net.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY PUBLIC ADDRESS AND NETWORK INTERFACE
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_public_ip" "net" {
  name                    = "pip-${var.postfix}"
  resource_group_name     = azurerm_resource_group.net.name
  location                = azurerm_resource_group.net.location
  allocation_method       = "Static"
  ip_version              = "IPv4"
  sku                     = "Basic"
  idle_timeout_in_minutes = "4"
  domain_name_label       = var.domain_name_label
}

resource "azurerm_network_interface" "net02" {
  name                = "nic-public-${var.postfix}"
  location            = azurerm_resource_group.net.location
  resource_group_name = azurerm_resource_group.net.name

  ip_configuration {
    name                          = "terratestconfiguration1"
    subnet_id                     = azurerm_subnet.net.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.net.id
  }
}