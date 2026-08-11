output "output_loadbalancer" {

  value = {

    for key, lb in azurerm_lb.lb :

    key => {

      id = lb.id

      name = lb.name

    }

  }

}