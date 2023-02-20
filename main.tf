
resource azurerm_subnet this {
  name                 = "snet-${lower(var.application)}-${lower(var.purpose)}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
}