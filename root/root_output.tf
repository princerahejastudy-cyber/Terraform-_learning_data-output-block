output "vnets" {
  value = {
    for key, vnet in module.vnet.output_vnets :
    key => vnet.name
  }
}

output "subnets" {
  value = {
    for key, subnet in module.subnet.output_subnets :
    key => subnet.name
  }
}

output "nsgs" {
  value = {
    for key, nsg in module.nsg.output_nsgs :
    key => nsg.name
  }
}



output "public_ips" {
  value = module.public_ip.output_publicip
}

output "nic_output" {
  value = module.nic.nic_output
}

output "bastion_output" {
  value = module.bastion.bastion_output
}