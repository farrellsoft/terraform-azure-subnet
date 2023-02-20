
variable application {
  type = string
  validation {
    condition     = length(var.application) > 3
    error_message = "${var.application} must be a minimum of three (3) characters."
  }
}

variable purpose {
  type        = string
  description = "The purpose of the resources being created."
}

variable resource_group_name {
  type        = string
  description = "The name of the resource group in which to create the resources."
}

variable virtual_network_name {
  type        = string
  description = "The name of the virtual network in which to create the resources."
}

variable address_prefixes {
  type        = list(string)
  description = "The address prefixes to use for the virtual network."
  validation {
    condition     = length(var.address_prefixes) > 0
    error_message = "At least one address prefix must be specified."
  }
}