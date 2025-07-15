variable "nic_name"{
    type = list(object({
        name = string
        ip_configuration = object({
            name = string
            private_ip_address_allocation = string
        })  
    }))
    default = [{
        name = "MyAppnic-tf",
        ip_configuration = {
            name = "AppIPConfig",
            private_ip_address_allocation = "Dynamic"
        }
    }]
}

variable "vm_name"{
    type = list(object({
        name = string
        size = string
        admin_username = string
        admin_password = string
        disable_password_authentication = bool
        os_disk = object({
            caching = string
            storage_account_type = string
        })
        source_image_reference = object({
            publisher = string
            offer = string
            sku = string
            version = string
        })    
    }))
    default = [{
        name = "MyAppvm-tf",
        size = "Standard_B1s",
        admin_username = "azureuser",
        admin_password = "Azureuser@1234",
        disable_password_authentication = false,
        os_disk = {
            caching = "ReadWrite",
            storage_account_type = "Standard_LRS"
        },
        source_image_reference = {
            publisher = "Canonical",
            offer = "0001-com-ubuntu-server-jammy",
            sku = "22_04-lts",
            version = "latest"
        }
    }]
}