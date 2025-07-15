# creation of NIC
resource "azurerm_network_interface" "nic" {
    name = var.nic_name.name
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    ip_configuration {
        name = var.nic_name.ip_configuration.name
        subnet_id = azurerm_subnet.subnet-app.id
        private_ip_address_allocation = var.nic_name.ip_configuration.private_ip_address_allocation
    }
}

# create Virtual machine for App
resource "azurerm_linux_virtual_machine" "vm" {
    name = var.vm_name.name
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    size = var.vm_size.size
    network_interface_ids = [azurerm_network_interface.App-nic.id]
    admin_username = var.vm_name.admin_username
    admin_password = var.vm_name.admin_password
    disable_password_authentication = var.vm_name.disable_password_authentication
    os_disk {
        caching = var.vm_name.os_disk.caching
        storage_account_type = var.vm_name.os_disk.storage_account_type
    }
    source_image_reference {
        publisher = var.vm_name.source_image_reference.publisher
        offer = var.vm_name.source_image_reference.offer
        sku = var.vm_name.source_image_reference.sku
        version = var.vm_name.source_image_reference.version
    }
}
