resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsg
  name                = each.value.name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "nsg_associaiton" {
  for_each                  = var.nsg
  subnet_id                 = var.subnets[each.value.subnet_key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id

}

resource "azurerm_network_security_rule" "nsg_rule" {
  for_each                    = var.nsg_rule
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg[each.value.nsg_key].name
}