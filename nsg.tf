resource azurerm_network_security_rule managevm {
    name                        = "Permit_management"
    protocol                    = "Tcp"
    source_address_prefixes     = var.management_iplist
    source_port_range           = "*"
    destination_address_prefix  = "*"
    destination_port_range      = 22
    access                      = "Allow"
    priority                    = 200
    direction                   = "Inbound"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.vm.name
}

resource azurerm_network_security_group vm {
  name                      = format("nsg-%s", var.vm_name)
  location                  = data.azurerm_resource_group.rg.location
  resource_group_name       = var.resource_group_name


  # 100-199 Security Scope
  
  # 200 - 249 Management scope

  # 300 - 400 Usage

  tags = var.basic_tags
}