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
        subnet_id = azurerm_subnet.subnet_private[each.key].id
        private_ip_address_allocation = var.private_nic[each.key].private_ip_address_allocation
    }
}

# creation of Virtual machine for in public subnets
resource "azurerm_linux_virtual_machine" "Public_subnet_vms" {
    for_each = var.subnet_public_CIDR
    name = "${each.key}-vm-tf"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    size = var.public_vm[each.key].size
    network_interface_ids = [azurerm_network_interface.public_NIC[each.key].id]
    admin_username = var.public_vm[each.key].admin_username
    admin_password = var.public_vm[each.key].admin_password
    disable_password_authentication = var.public_vm[each.key].disable_password_authentication
    os_disk {
        caching = var.public_vm[each.key].os_disk.caching
        storage_account_type = var.public_vm[each.key].os_disk.storage_account_type
    }
    source_image_reference {
        publisher = var.public_vm[each.key].source_image_reference.publisher
        offer = var.public_vm[each.key].source_image_reference.offer
        sku = var.public_vm[each.key].source_image_reference.sku
        version = var.public_vm[each.key].source_image_reference.version
    }
}

# creation of Virtual machine for in private subnets
resource "azurerm_linux_virtual_machine" "Private_subnet_vms" {
    for_each = var.subnet_private_CIDR
    name = "${each.key}-vm-tf"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    size = var.private_vm[each.key].size
    network_interface_ids = [azurerm_network_interface.private_NIC[each.key].id]
    admin_username = var.private_vm[each.key].admin_username
    admin_password = var.private_vm[each.key].admin_password
    disable_password_authentication = var.private_vm[each.key].disable_password_authentication
    os_disk {
        caching = var.private_vm[each.key].os_disk.caching
        storage_account_type = var.private_vm[each.key].os_disk.storage_account_type
    }
    source_image_reference {
        publisher = var.private_vm[each.key].source_image_reference.publisher
        offer = var.private_vm[each.key].source_image_reference.offer
        sku = var.private_vm[each.key].source_image_reference.sku
        version = var.private_vm[each.key].source_image_reference.version
    }
}