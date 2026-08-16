variable "resource_group_name" {
  # description = "Existing Azure Resource Group Name"
  # type        = string
}

variable "vnets" {
  # description = "Virtual Networks to create"
  # type = map(object({
  #   name          = string
  #   address_space = list(string)
  # }))
}


variable "subnets" {
  #   description = "Subnets to create"
  #   type = map(object({
  #   name             = string
  #   vnet_key         = string
  #   address_prefixes = list(string)
  # }))
}

variable "nsg" {}
variable "nsg_rules" {}
variable "public_ip_root" {}
variable "nat_gw_tf_root" {}
variable "nic_tf_root" {}
variable "bastion_host_root" {}
variable "virtual_machine_root" {}
variable "loadbalancers" {}
variable "nat_rules" {}
variable "appgateways" {}