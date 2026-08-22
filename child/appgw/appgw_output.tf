# output "appgw_output" {
#   value = {
#     for k, appgw in azurerm_application_gateway.appgw : k => {
#       id   = appgw.id
#       name = appgw.name
#     }
#   }
# }
