
output "output_publicip" {
  value = {
    for key, pip in azurerm_public_ip.publicip_tf_code :
    key => {
      id         = pip.id
      name       = pip.name
      ip_address = pip.ip_address
    }
  }
}