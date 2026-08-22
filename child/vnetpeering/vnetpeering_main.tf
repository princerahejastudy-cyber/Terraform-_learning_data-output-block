resource "azurerm_virtual_network_peering" "peering" {
    for_each = var.peerings
    name = each.key
    resource_group_name = data.azurerm_resource_group.rg.name
    virtual_network_name =var.vnets[each.value.vnet_key].name
    remote_virtual_network_id =var.vnets[each.value.remote_vnet_key].id
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
}