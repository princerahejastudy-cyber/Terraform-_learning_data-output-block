output "bastion_output" {
  value = {
    for k, bastion_host in azurerm_bastion_host.bastion_host :
    k => {
      id   = bastion_host.id
      name = bastion_host.name
    }
  }
}