
#Bastion Subnet
resource "azurerm_subnet" "bastion_subnet" {
  for_each             = var.bastion_host
  name                 = "AzureBastionSubnet"
  resource_group_name  = data.azurerm_resource_group.rg.name                #datamodule
  virtual_network_name = var.virtual_network_name[each.value.vnet_key].name #root se call vnetoutput
  address_prefixes     = each.value.address_prefixes                        #tfvars
}

# Bastion Host
resource "azurerm_bastion_host" "bastion_host" {
  for_each            = var.bastion_host
  name                = each.value.name                         ##tfvars
  location            = data.azurerm_resource_group.rg.location #datamodule
  resource_group_name = data.azurerm_resource_group.rg.name     #datamodule

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_subnet[each.key].id            #bastion subnet se call hoga
    public_ip_address_id = var.public_ip_address_id[each.value.public_ip_key].id #root se call publiciooutput
  }
}

