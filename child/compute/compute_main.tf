resource "azurerm_linux_virtual_machine" "virtual_machine" {
  for_each                        = var.virtual_machine
  name                            = each.value.name                         #TFvars
  resource_group_name             = data.azurerm_resource_group.rg.name     #data block
  location                        = data.azurerm_resource_group.rg.location #data block
  size                            = each.value.size                         #TFvars
  admin_username                  = each.value.admin_username               #TFvars
  network_interface_ids           = [var.network_interface_ids[each.value.nic_key].id]
  disable_password_authentication = each.value.disable_password_authentication
  admin_password                  = each.value.admin_password #TFvars

  os_disk {
    caching              = each.value.caching              #TFvars
    storage_account_type = each.value.storage_account_type #TFvars
  }

  source_image_reference {
    publisher = each.value.publisher #TFvars
    offer     = each.value.offer     #TFvars
    sku       = each.value.sku       #TFvars
    version   = each.value.version   #TFvars
  }
  custom_data = base64encode(<<-EOF
    #!/bin/bash

    apt-get update -y
    apt-get install -y nginx

    systemctl enable nginx
    systemctl start nginx

    cat > /var/www/html/index.nginx-debian.html <<HTML
    <!DOCTYPE html>
    <html>
    <head>
        <title>Terraform VM</title>
    </head>
    <body>
        <h1>${each.key}</h1>
        <h2>Nginx Server</h2>
        <p>Deployed automatically using Terraform</p>
    </body>
    </html>
    HTML

    systemctl restart nginx
  EOF
  )
}

