resource_group_name = "kml_rg_main-95a8d98c47cf46fb"

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
    name             = "dev-subnet-Frontend"
    vnet_key         = "vnet1"
    address_prefixes = ["10.0.1.0/24"]
  }
  subnet2 = {
    name             = "dev-subnet-Backend"
    vnet_key         = "vnet1"
    address_prefixes = ["10.0.2.0/24"]
  }
  subnet3 = {
    name             = "Test-subnet-Test"
    vnet_key         = "vnet2"
    address_prefixes = ["20.0.1.0/24"]
  }
}


nsg = {
  nsg1 = {
    name       = "dev-subnet-Frontend-nsg"
    subnet_key = "subnet1"
  }
  nsg1 = {
    name       = "dev-subnet-Backend-nsg"
    subnet_key = "subnet2"
  }
  nsg2 = {
    name       = "Test-subnet-Test-nsg"
    subnet_key = "subnet3"
  }
}

nsg_rules = {

  allow_ssh = {
    nsg_key                    = "nsg1"
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
    nsg_key                    = "nsg2"
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

public_ip_root = {
  publicip1 = {
    name              = "dev-subnet-Frontend-publicip1-natgw"
    allocation_method = "Static"
    sku               = "Standard"
  }
  publicip2 = {
    name              = "dev-subnet-Backend-publicip2-natgw"
    allocation_method = "Static"
    sku               = "Standard"
  }
  publicip3 = {
    name              = "Test-subnet-Test-publicip3-natgw"
    allocation_method = "Static"
    sku               = "Standard"
  }
  publicip4 = {
    name              = "Dev-publicip4-bastion"
    allocation_method = "Static"
    sku               = "Standard"
  }
}

nat_gw_tf_root = {
  natgw1 = {
    name          = "dev-subnet-Frontend-natgw"
    public_ip_key = "publicip1"
    sku           = "Standard"
    subnet_key    = "subnet1"
  }
  natgw2 = {
    name          = "dev-subnet-Backend-natgw"
    public_ip_key = "publicip2"
    sku           = "Standard"
    subnet_key    = "subnet2"
  }
  natgw3 = {
    name          = "Test-subnet-Test-natgw"
    public_ip_key = "publicip3"
    sku           = "Standard"
    subnet_key    = "subnet3"
  }
}

nic_tf_root = {
  nic1 = {
    name                          = "dev-subnet-Frontend-nic1"
    private_ip_address_allocation = "Dynamic"
    subnet_key    = "subnet1"
  }
  nic2 = {
    name                          = "dev-subnet-Frontend-nic2"
    private_ip_address_allocation = "Dynamic"
    subnet_key    = "subnet1"
  }
  nic3 = {
    name                          = "dev-subnet-backend-nic1"
    private_ip_address_allocation = "Dynamic"
    subnet_key    = "subnet2"
}
}

bastion_host_root={
  bastion1={
    name="dev-bastion-host"
    public_ip_key = "publicip4"
    vnet_key ="vnet1"
    address_prefixes=["10.0.3.0/24"]
  }
}