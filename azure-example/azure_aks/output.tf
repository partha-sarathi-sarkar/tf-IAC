output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
}

output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.example.kube_config.0.cluster_ca_certificate
}

output "client_key" {
  value = azurerm_kubernetes_cluster.example.kube_config.0.client_key
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}

output "cluster_password" {
  value = azurerm_kubernetes_cluster.example.kube_config.0.password
}

output "host" {
  value = azurerm_kubernetes_cluster.example.kube_config.0.host
}