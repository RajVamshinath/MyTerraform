# creation of NIC
resource "azurerm_network_interface" "App-nic" {
    name = "App-nic-tf"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    ip_configuration {
        name = "AppIPConfig"
        subnet_id = azurerm_subnet.subnet-app.id
        private_ip_address_allocation = "Dynamic"
    }
}

# create Virtual machine for App
resource "azurerm_linux_virtual_machine" "App-vm" {
    name = "App-vm-tf"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    size = "Standard_B1s"
    network_interface_ids = [azurerm_network_interface.App-nic.id]
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
