output "output_subnets" {
  description = "Details of all created subnets"

  value = {
    for key, subnet in azurerm_subnet.subnet : key => {
      id   = subnet.id
      name = subnet.name
    }
  }
}