module "vnet" {
  source              = "../child/vnet"
  resource_group_name = var.resource_group_name
  vnets               = var.vnets
}


module "subnet" {
  source              = "../child/subnet"
  resource_group_name = var.resource_group_name
  #child variable = root varaible -->> TFVars
  vnets   = module.vnet.output_vnets
  subnets = var.subnets
}


module "nsg" {
  source              = "../child/nsg"
  resource_group_name = var.resource_group_name
  nsg                 = var.nsg
  subnets             = module.subnet.output_subnets
  nsg_rule            = var.nsg_rules
}

module "public_ip" {
  source              = "../child/PublicIp"
  resource_group_name = var.resource_group_name
  publicip_tf_code    = var.public_ip_root
}

module "nat_gw" {
  source              = "../child/natgateway"
  resource_group_name = var.resource_group_name
  nat_gw_tf           = var.nat_gw_tf_root
  subnets             = module.subnet.output_subnets
  public_ip           = module.public_ip.output_publicip
}

module "nic" {
  source              = "../child/nic"
  resource_group_name = var.resource_group_name
  subnet_id           = module.subnet.output_subnets
  nic                 = var.nic_tf_root
}

module "bastion" {
  source               = "../child/bastion"
  resource_group_name  = var.resource_group_name
  bastion_host         = var.bastion_host_root
  public_ip_address_id = module.public_ip.output_publicip
  virtual_network_name = module.vnet.output_vnets
}

module "vm" {
  source                = "../child/compute"
  resource_group_name   = var.resource_group_name
  virtual_machine       = var.virtual_machine_root
  network_interface_ids = module.nic.nic_output
}

#module "loadbalancer" {
#source              = "../child/loadbalance"
#resource_group_name = var.resource_group_name
#loadbalancers       = var.loadbalancers
#public_ips          = module.public_ip.output_publicip
#nics                = module.nic.nic_output
#nat_rules           = var.nat_rules
#}

module "appgw" {
  source              = "../child/appgw"
  resource_group_name = var.resource_group_name
  appgateways         = var.appgateways
  subnets             = module.subnet.output_subnets
  public_ips          = module.public_ip.output_publicip
  nics                = module.nic.nic_output
}