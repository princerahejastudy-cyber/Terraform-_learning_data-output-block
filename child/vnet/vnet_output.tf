output "output_vnets" {

  description = "Details of all created VNets"

  value = {
    for key, vnet in azurerm_virtual_network.vnet : key => {
      id   = vnet.id
      name = vnet.name
    }
  }

}