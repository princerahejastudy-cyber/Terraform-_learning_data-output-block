resource "azurerm_nat_gateway" "nat_gw_tf" {
  for_each            = var.nat_gw_tf
  name                = each.value.name                         #tfvars
  location            = data.azurerm_resource_group.rg.location # data block
  resource_group_name = data.azurerm_resource_group.rg.name     # data block
  sku_name            = each.value.sku                          # tfvars
}

resource "azurerm_subnet_nat_gateway_association" "natgw_assoc" {
  for_each       = var.nat_gw_tf
  subnet_id      = var.subnets[each.value.subnet_key].id
  nat_gateway_id = azurerm_nat_gateway.nat_gw_tf[each.key].id
}

resource "azurerm_nat_gateway_public_ip_association" "natgw_publicip_assoc" {
  for_each             = var.nat_gw_tf
  nat_gateway_id       = azurerm_nat_gateway.nat_gw_tf[each.key].id
  public_ip_address_id = var.public_ip[each.value.public_ip_key].id
}


