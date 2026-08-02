module "vnet" {
  source              = "../child/vnet"
  resource_group_name = var.resource_group_name
  vnets               = var.vnets
}


module "subnet" {
  source = "../child/subnet"
  resource_group_name = var.resource_group_name
  #child variable = root varaible -->> TFVars
  vnets = module.vnet.output_vnets
  subnets = var.subnets
}


module "nsg" {
  source= "../child/nsg"
  resource_group_name = var.resource_group_name
  nsg =var.nsg
  subnets = module.subnet.output_subnets
  nsg_rule = var.nsg_rules
}

module "public_ip" {
  source = "../child/PublicIp"
  resource_group_name = var.resource_group_name
  publicip_tf_code = var.public_ip_root
}

module "nat_gw" {
  source ="../child/natgateway"
  resource_group_name = var.resource_group_name
  nat_gw_tf=var.nat_gw_tf_root
  subnets = module.subnet.output_subnets
  public_ip = module.public_ip.output_publicip
}