resource_group_name = "kml_rg_main-be9271cab2c44da2"

vnets = {

  vnet1 = {
    name          = "dev-vnet"
    address_space = ["10.0.0.0/16"]
  }
  vnet2 = {
    name          = "test-vnet"
    address_space = ["20.0.0.0/16"]
  }

}

subnets = {
  subnet1 = {
  name             = "subnet-dev"
  vnet_key         = "vnet1"
  address_prefixes = ["10.0.1.0/24"]
}
 subnet2 = {
  name             = "subnet-test"
  vnet_key         = "vnet2"
  address_prefixes = ["20.0.1.0/24"]
}
}

nsg={
  nsg1={
    name="subnet-dev-nsg"
    subnet_key = "subnet1"
  }
  nsg2={
    name="subnet-test-nsg"
    subnet_key = "subnet2"
  }
}

nsg_rules = {

  allow_ssh = {
    nsg_key = "nsg1"
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

   allow_ssh2 = {
    nsg_key = "nsg2"
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

public_ip_root={
  publicip1 = {
    name              = "publicip1-natgw"
    allocation_method = "Static"
    sku ="Standard"
  }
  publicip2 = {
    name              = "publicip2-natgw"
    allocation_method = "Static"
    sku ="Standard"
  }
}

nat_gw_tf_root ={
  natgw1 = {
  name = "natgw1"
  public_ip_key = "publicip1"
  sku = "Standard"
  subnet_key ="subnet1"
}
natgw2 = {
  name = "natgw2"
  public_ip_key = "publicip2"
  sku = "Standard"
  subnet_key ="subnet2"
}
}


   