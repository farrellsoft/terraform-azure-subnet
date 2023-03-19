
terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}

data azurerm_client_config current {}

locals {
  virtual_network_id  = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}"
  delegations         = [for key,value in var.delegations : {
    name = key
    properties = {
      serviceName = value.service_name
    }
  }]
}

resource azapi_resource this {
  type          = "Microsoft.Network/virtualNetworks/subnets@2022-07-01"
  name          = "snet-${lower(var.application)}-${lower(var.purpose)}"
  parent_id     = local.virtual_network_id

  body = jsonencode({
    properties        = {
      addressPrefixes                     = var.address_prefixes
      privateEndpointNetworkPolicies      = var.enable_private_endpoint_policies ? "Enabled" : "Disabled"
      privateLinkServiceNetworkPolicies   = var.enable_private_link_service_network_policies ? "Enabled" : "Disabled"
      delegations                         = local.delegations
    }
  })
}