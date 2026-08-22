resource_group_name = "kml_rg_main-fceed7684fcc4dc4"

vnets = {

  vnet1 = {
    name          = "dev-vnet"
    address_space = ["10.0.0.0/16"]
  }
  vnet2 = {
    name          = "Hub-vnet"
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
    name             = "Hub-subnet"
    vnet_key         = "vnet2"
    address_prefixes = ["20.0.1.0/24"]
  }
  # subnet_appgw = {
  #   name             = "dev-subnet-AppGateway"
  #   vnet_key         = "vnet1"
  #   address_prefixes = ["10.0.4.0/24"]
  # }
}



nsg = {
  nsg1 = {
    name       = "dev-subnet-Frontend-nsg"
    subnet_key = "subnet1"
  }
  nsg2 = {
    name       = "dev-subnet-Backend-nsg"
    subnet_key = "subnet2"
  }
  nsg3 = {
    name       = "Hub-subnet-Hub-nsg"
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
  allow_http1 = {
    nsg_key                    = "nsg1"
    name                       = "Allow-HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  allow_http2 = {
    nsg_key                    = "nsg2"
    name                       = "Allow-HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


public_ip_root = {
  publicip1 = {
    name              = "dev-subnet-Frontend-publicip1-natgw"
    allocation_method = "Static"
    sku               = "StandardV2"
  }
  publicip2 = {
    name              = "dev-subnet-Backend-publicip2-natgw"
    allocation_method = "Static"
    sku               = "StandardV2"
  }
  publicip3 = {
    name              = "Hub-subnet-Hub-publicip3-natgw"
    allocation_method = "Static"
    sku               = "StandardV2"
  }
  publicip4 = {
    name              = "Hub-publicip4-bastion"
    allocation_method = "Static"
    sku               = "Standard"
  }
  publicip5 = {
    name              = "Loab_Balancer_Public_IP"
    allocation_method = "Static"
    sku               = "Standard"
  }
  # publicip6 = {
  #   name              = "Loab_Balancer2_Public_IP"
  #   allocation_method = "Static"
  #   sku               = "Standard"
  # }
  # publicip_appgw = {
  #   name              = "dev-appgw-publicip"
  #   allocation_method = "Static"
  #   sku               = "Standard"
  # }
}



nat_gw_tf_root = {
  natgw1 = {
    name          = "dev-subnet-Frontend-natgw"
    public_ip_key = "publicip1"
    sku           = "StandardV2"
    subnet_key    = "subnet1"
  }
  natgw2 = {
    name          = "dev-subnet-Backend-natgw"
    public_ip_key = "publicip2"
    sku           = "StandardV2"
    subnet_key    = "subnet2"
  }
  natgw3 = {
    name          = "Hub-subnet-Hub-natgw"
    public_ip_key = "publicip3"
    sku           = "StandardV2"
    subnet_key    = "subnet3"
  }
}

nic_tf_root = {
  nic1 = {
    name                          = "dev-subnet-Frontend-nic1"
    private_ip_address_allocation = "Dynamic"
    subnet_key                    = "subnet1"
  }
  nic2 = {
    name                          = "dev-subnet-Frontend-nic2"
    private_ip_address_allocation = "Dynamic"
    subnet_key                    = "subnet1"
  }
  nic3 = {
    name                          = "dev-subnet-backend-nic1"
    private_ip_address_allocation = "Dynamic"
    subnet_key                    = "subnet2"
  }
}

bastion_host_root = {
  bastion1 = {
    name             = "Hub-bastion-host"
    public_ip_key    = "publicip4"
    vnet_key         = "vnet2"
    address_prefixes = ["20.0.3.0/24"]
  }
}

virtual_machine_root = {
  vm1 = {
    name                            = "Frontend-vm1"
    size                            = "Standard_D2s_v3"
    admin_username                  = "adminuser"
    nic_key                         = "nic1"
    admin_password                  = "Uddish@786"
    caching                         = "ReadWrite"
    publisher                       = "Canonical"
    offer                           = "UbuntuServer"
    sku                             = "16.04-LTS"
    version                         = "latest"
    disable_password_authentication = "false"
    storage_account_type            = "Standard_LRS"
  }
  vm2 = {
    name                            = "Frontend-vm2"
    size                            = "Standard_D2s_v3"
    admin_username                  = "adminuser"
    nic_key                         = "nic2"
    admin_password                  = "Uddish@786"
    caching                         = "ReadWrite"
    publisher                       = "Canonical"
    offer                           = "UbuntuServer"
    sku                             = "16.04-LTS"
    version                         = "latest"
    disable_password_authentication = "false"
    storage_account_type            = "Standard_LRS"
  }
  vm3 = {
    name                            = "Bacbken-vm2"
    size                            = "Standard_D2s_v3"
    admin_username                  = "adminuser"
    nic_key                         = "nic3"
    admin_password                  = "Uddish@786"
    caching                         = "ReadWrite"
    publisher                       = "Canonical"
    offer                           = "UbuntuServer"
    sku                             = "16.04-LTS"
    version                         = "latest"
    disable_password_authentication = "false"
    storage_account_type            = "Standard_LRS"
  }
}


loadbalancers = {

  lb1 = {

    name = "frontend-lb"

    sku = "Standard"

    sku_tier = "Regional"

    public_ip_key = "publicip5"

    frontend_name = "frontend-ip"

    backend_pool_name = "backend-pool"

    probe_name = "http-probe"

    probe_port = 80

    rule_name = "http-rule"

    protocol = "Tcp"

    frontend_port = 80

    backend_port = 80

    nic_keys = [
      "nic1",
      "nic2"
    ]

  }

}

nat_rules = {

  vm1 = {

    lb_key = "lb1"

    nic_key = "nic1"

    name = "ssh-vm1"

    protocol = "Tcp"

    frontend_port = 50001

    backend_port = 22

    frontend_ip_config_name = "frontend-ip"

  }

  vm2 = {

    lb_key = "lb1"

    nic_key = "nic2"

    name = "ssh-vm2"

    protocol = "Tcp"

    frontend_port = 50002

    backend_port = 22

    frontend_ip_config_name = "frontend-ip"

  }

}

# appgateways = {
#   appgw1 = {
#     name          = "dev-appgateway"
#     sku_name      = "Standard_v2"
#     sku_tier      = "Standard_v2"
#     sku_capacity  = 2
#     subnet_key    = "subnet_appgw"
#     public_ip_key = "publicip_appgw"

#     backend_pools = {
#       images = {
#         name     = "images-backend-pool"
#         nic_keys = ["nic1"]
#       }
#       videos = {
#         name     = "videos-backend-pool"
#         nic_keys = ["nic2"]
#       }
#     }

#     http_settings = {
#       name                  = "http-setting"
#       cookie_based_affinity = "Disabled"
#       port                  = 80
#       protocol              = "Http"
#       request_timeout       = 20
#     }

#     path_rules = {
#       images = {
#         name             = "images-rule"
#         paths            = ["/images/*"]
#         backend_pool_key = "images"
#       }
#       videos = {
#         name             = "videos-rule"
#         paths            = ["/videos/*"]
#         backend_pool_key = "videos"
#       }
#     }
#   }
# }

peerings = {
  vnet1_to_vnet2 = {
    vnet_key        = "vnet1"
    remote_vnet_key = "vnet2"
  }
  vnet2_to_vnet1 = {
    vnet_key        = "vnet2"
    remote_vnet_key = "vnet1"
  }
}