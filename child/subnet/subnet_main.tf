resource "azurerm_subnet" "subnet" {
    for_each = var.subnets
    name = each.value.name
    resource_group_name = data.azurerm_resource_group.rg.name
    virtual_network_name = var.vnets[each.value.vnet_key].name
    address_prefixes = each.value.address_prefixes
}