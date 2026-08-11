output "nic_output" {
  value = {
    for k, nic in azurerm_network_interface.nic_tf :
    k => {
      id   = nic.id
      name = nic.name
      private_ip = nic.private_ip_address
    }
  }
}