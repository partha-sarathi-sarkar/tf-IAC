
output "public_address_name" {
  value = azurerm_public_ip.net.name
}

output "network_interface_internal" {
  value = azurerm_network_interface.net01.name
}

output "network_interface_external" {
  value = azurerm_network_interface.net02.name
}