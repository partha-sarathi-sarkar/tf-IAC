output "resource_group_name" {
  value = azurerm_resource_group.net.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.net.name
}

output "subnet_name" {
  value = azurerm_subnet.net.name
}