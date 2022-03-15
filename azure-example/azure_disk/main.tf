
# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A RESOURCE GROUP
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_resource_group" "rg" {
  name     =  var.rg-name
  location = var.location
}


# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY THE DISK
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_managed_disk" "disk" {
  name                 = var.diskname
  location             = var.location
  resource_group_name  = var.rg-name
  storage_account_type = var.disk_type
  create_option        = "Empty"
  disk_size_gb         = 10

  depends_on = [
    azurerm_resource_group.rg
  ]

  tags = {
    Environment = var.environment
  }
}