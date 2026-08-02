variable "resource_group_name" {
#   description = "Existing Azure Resource Group Name"
#   type        = string
}

variable "subnets" {
#   description = "Subnets to create"

#   type = map(object({
#     name             = string
#     vnet_key         = string
#     address_prefixes = list(string)
#   }))
}

variable "vnets" {
#   description = "VNet details received from VNet module"

#   type = map(object({
#     id   = string
#     name = string
#   }))
}