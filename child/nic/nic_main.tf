
resource "azurerm_network_interface" "nic_tf" {
    for_each = var.nic
  name                = each.value.name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id[each.value.subnet_key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }
}