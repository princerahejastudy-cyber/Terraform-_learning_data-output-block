output "output_nsgs" {
  description = "Details of all created subnets"

  value = {
    for key, nsg in azurerm_network_security_group.nsg : key => {
      id   = nsg.id
      name = nsg.name
    }
  }
}

