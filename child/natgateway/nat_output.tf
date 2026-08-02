
output "output_natgw" {
  value = {
    for key, natgw in azurerm_nat_gateway.nat_gw_tf :
    key => {
      id   = natgw.id
      name = natgw.name
    }
  }
}

