###############################
# Load Balancer
###############################

resource "azurerm_lb" "lb" {
  for_each = var.loadbalancers

  name                = each.value.name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  sku      = each.value.sku
  sku_tier = each.value.sku_tier

  frontend_ip_configuration {
    name                 = each.value.frontend_name
    public_ip_address_id = var.public_ips[each.value.public_ip_key].id
  }
}

###############################
# Backend Pool
###############################

resource "azurerm_lb_backend_address_pool" "backendpool" {
  for_each = var.loadbalancers

  loadbalancer_id = azurerm_lb.lb[each.key].id
  name            = each.value.backend_pool_name
}

###############################
# Health Probe
###############################

resource "azurerm_lb_probe" "probe" {
  for_each = var.loadbalancers

  loadbalancer_id = azurerm_lb.lb[each.key].id

  name = each.value.probe_name
  port = each.value.probe_port

  protocol = "Tcp"
}

###############################
# Load Balancer Rule
###############################

resource "azurerm_lb_rule" "rule" {
  for_each = var.loadbalancers

  loadbalancer_id = azurerm_lb.lb[each.key].id

  name = each.value.rule_name

  protocol      = each.value.protocol
  frontend_port = each.value.frontend_port
  backend_port  = each.value.backend_port

  frontend_ip_configuration_name = each.value.frontend_name

  backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.backendpool[each.key].id
  ]

  probe_id = azurerm_lb_probe.probe[each.key].id
}

###############################
# NIC Association
###############################

locals {
  nic_lb_map = flatten([
    for lb_key, lb in var.loadbalancers : [
      for nic_key in lb.nic_keys : {
        lb_key  = lb_key
        nic_key = nic_key
      }
    ]
  ])
}

resource "azurerm_network_interface_backend_address_pool_association" "association" {

  for_each = {
    for item in local.nic_lb_map :
    "${item.lb_key}-${item.nic_key}" => item
  }

  network_interface_id = var.nics[each.value.nic_key].id

  ip_configuration_name = "internal"

  backend_address_pool_id = azurerm_lb_backend_address_pool.backendpool[each.value.lb_key].id
}


resource "azurerm_lb_nat_rule" "nat_rule" {
    for_each = var.nat_rules
    resource_group_name = data.azurerm_resource_group.rg.name
    loadbalancer_id = azurerm_lb.lb[each.value.lb_key].id
    name = each.value.name
    protocol = each.value.protocol
    frontend_port = each.value.frontend_port
    backend_port = each.value.backend_port
    frontend_ip_configuration_name = each.value.frontend_ip_config_name
}

resource "azurerm_network_interface_nat_rule_association" "nat_association" {
    for_each = var.nat_rules
    network_interface_id = var.nics[each.value.nic_key].id
    ip_configuration_name = "internal"
    nat_rule_id = azurerm_lb_nat_rule.nat_rule[each.key].id
}