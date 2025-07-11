# creation of nic for public subnets
resource "azurerm_network_interface" "public_NIC"{
    for_each = var.subnet_public_CIDR
    name = "${each.key}-nic-tf"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    ip_configuration {
        name = var.public_nic[each.key].name
        subnet_id = azurerm_subnet.subnet_public[each.key].id
        private_ip_address_allocation = var.public_nic[each.key].private_ip_address_allocation
    }
}

# creation of nic for private subnets
resource "azurerm_network_interface" "private_NIC"{
    for_each = var.subnet_private_CIDR
    name = "${each.key}-nic-tf"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    ip_configuration {
        name = var.private_nic[each.key].name
        subnet_id = azurerm_subnet.subnet_private_db[each.key].id
        private_ip_address_allocation = var.private_nic[each.key].private_ip_address_allocation
    }
}