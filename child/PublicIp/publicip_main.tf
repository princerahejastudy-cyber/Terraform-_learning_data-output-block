resource "azurerm_public_ip" "publicip_tf_code" {
    for_each = var.publicip_tf_code
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = each.value.allocation_method
  sku = each.value.sku
}

