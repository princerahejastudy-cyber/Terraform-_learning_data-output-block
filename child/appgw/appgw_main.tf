# resource "azurerm_application_gateway" "appgw" {
#   for_each            = var.appgateways
#   name                = each.value.name
#   resource_group_name = data.azurerm_resource_group.rg.name
#   location            = data.azurerm_resource_group.rg.location

#   sku {
#     name     = each.value.sku_name
#     tier     = each.value.sku_tier
#     capacity = each.value.sku_capacity
#   }

#   gateway_ip_configuration {
#     name      = "${each.value.name}-ip-config"
#     subnet_id = var.subnets[each.value.subnet_key].id
#   }

#   frontend_port {
#     name = "${each.value.name}-frontend-port"
#     port = 80
#   }

#   frontend_ip_configuration {
#     name                 = "${each.value.name}-frontend-ip-config"
#     public_ip_address_id = var.public_ips[each.value.public_ip_key].id
#   }

#   dynamic "backend_address_pool" {
#     for_each = each.value.backend_pools
#     content {
#       name         = backend_address_pool.value.name
#       ip_addresses = [for nic_k in backend_address_pool.value.nic_keys : var.nics[nic_k].private_ip]
#     }
#   }

#   backend_http_settings {
#     name                  = each.value.http_settings.name
#     cookie_based_affinity = each.value.http_settings.cookie_based_affinity
#     port                  = each.value.http_settings.port
#     protocol              = each.value.http_settings.protocol
#     request_timeout       = each.value.http_settings.request_timeout
#   }

#   http_listener {
#     name                           = "${each.value.name}-http-listener"
#     frontend_ip_configuration_name = "${each.value.name}-frontend-ip-config"
#     frontend_port_name             = "${each.value.name}-frontend-port"
#     protocol                       = "Http"
#   }

#   url_path_map {
#     name                               = "${each.value.name}-url-path-map"
#     default_backend_address_pool_name  = each.value.backend_pools["images"].name
#     default_backend_http_settings_name = each.value.http_settings.name

#     dynamic "path_rule" {
#       for_each = each.value.path_rules
#       content {
#         name                       = path_rule.value.name
#         paths                      = path_rule.value.paths
#         backend_address_pool_name  = each.value.backend_pools[path_rule.value.backend_pool_key].name
#         backend_http_settings_name = each.value.http_settings.name
#       }
#     }
#   }

#   request_routing_rule {
#     name               = "${each.value.name}-routing-rule"
#     rule_type          = "PathBasedRouting"
#     http_listener_name = "${each.value.name}-http-listener"
#     url_path_map_name  = "${each.value.name}-url-path-map"
#     priority           = 10
#   }
# }
