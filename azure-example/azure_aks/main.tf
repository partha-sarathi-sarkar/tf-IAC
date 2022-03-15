
# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A RESOURCE GROUP
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_resource_group" "rg" {
  name     =  var.rg-name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = var.clustername
  location            = var.location
  resource_group_name = var.rg-name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

depends_on = [
  azurerm_resource_group.rg
]

  tags = {
    Environment = var.environment
  }
}