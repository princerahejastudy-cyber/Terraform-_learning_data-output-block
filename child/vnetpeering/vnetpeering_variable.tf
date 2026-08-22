variable "resource_group_name" {
  # description = "Existing Azure Resource Group Name"
  # type        = string
}

variable "vnets" {
  #   description = "VNet details received from VNet module"

  #   type = map(object({
  #     id   = string
  #     name = string
  #   }))
}
variable "peerings" {}