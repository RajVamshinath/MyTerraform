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

# create Virtual machine in public subnet for App
resource "azurerm_linux_virtual_machine" "App-vm" {
    for_each = var.subnet_public_CIDR
    name = "App-vm-tf"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    size = "Standard_B1s"
    network_interface_ids = [azurerm_network_interface.public_NIC.id]
    admin_username = "azureuser"
    admin_password = "Azureuser@1234"
    disable_password_authentication = "false"
    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
        publisher = "Canonical"
        offer = "0001-com-ubuntu-server-jammy"
        sku = "22_04-lts"
        version = "latest"
    }
}