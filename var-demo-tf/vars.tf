# variable for resource group name
variable "resource_group_name"{
    type = string
    default = "Myrg-tf"
}

# varibale for resource group location
variable "resource_group_location"{
    type = string
    default = "East US"
}

# variable for virtual network
variable "virtual_network_name"{
    type = string
    default = "Myvnet-tf"
}

# variable for virtual network address prefixes
variable "virtual_network_address_prefixes"{       
    type = list(string)
    default = ["10.0.0.0/24"]
}

# varibale for public subnets CIDR
variable "subnet_public_CIDR"{
    type = map(string)
    default = {
        "Myapp" = "10.0.0.0/28",
        "Myweb" = "10.0.0.16/28"
    }
}

# variable for private subnet name - db
variable "subnet_private_CIDR"{
    type = map(string)
    default = {
        "Mydb" = "10.0.0.48/28"
    }
}

# variable for security rules for public subnet network security groups
variable "nsg_public_security_rules"{
    type = map(object({
        name = string
        priority = number
        direction = string
        access = string
        protocol = string
        source_port_range = string
        destination_port_range = string
        source_address_prefix = string
        destination_address_prefix = string
    }))
    default = {
        "Myapp" = {
            name = "AllowAppTraffic"
            priority = 100
            direction = "Inbound"
            access = "Allow"
            protocol = "Tcp"
            source_port_range = "*"
            destination_port_range = "8080"
            source_address_prefix = "*"
            destination_address_prefix = "*"
        }
    }
}

# variable for security rules for private subnet network security groups
variable "nsg_private_security_rules"{
    type = map(object({
        name = string
        priority = number
        direction = string
        access = string
        protocol = string
        source_port_range = string
        destination_port_range = string
        source_address_prefix = string
        destination_address_prefix = string
    }))
    default = {
        "Mydb" = {
            name = "AllowAppTraffic"
            priority = 100
            direction = "Inbound"
            access = "Allow"
            protocol = "Tcp"
            source_port_range = "*"
            destination_port_range = "5432"
            source_address_prefix = "*"
            destination_address_prefix = "*"
        }
    }
}

# variable for NAT gateway
variable "NAT_gateway_name"{
    type = string
    default = "MyNatGateway-tf"
}

# variable for NAT gateway public IP
variable "NAT_publicIP"{
    type = string
    default = "MyNatPublicIP-tf"
}

# variable for NAT gateway public IP allocation method
variable "NAT_publicIP_allocation_method"{
    type = string
    default = "Static"
}

# variable for Public NICs - IPConfig
variable "public_nic"{
    type = map(object({
        name = string
        private_ip_address_allocation = string
    }))
    default = {
        "Myapp" = {
            name = "MyappNIC-IPConfig"
            private_ip_address_allocation = "Dynamic"
        },
        "Myweb" = {
            name = "MywebNIC-IPConfig"
            private_ip_address_allocation = "Dynamic"
        }
    }
}

# variable for Private NICs - IPConfig
variable "private_nic"{
    type = map(object({
        name = string
        private_ip_address_allocation = string
    }))
    default = {
        "Mydb" = {
            name = "MydatabaseNIC-IPConfig"
            private_ip_address_allocation = "Dynamic"
        }
    }
}

# variable for Public Subnet VMs
variable "public_vm"{
    type = map(object({
        size = string
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
        admin_username = string
        admin_password = string
    }))
    default = {
        "Myapp" = {
            size = "Standard_B1s"
            disable_password_authentication = false
            os_disk = {
                caching = "ReadWrite"
                storage_account_type = "Standard_LRS"
            }
            source_image_reference = {
                publisher = "Canonical"
                offer = "0001-com-ubuntu-server-jammy"
                sku = "22_04-lts"
                version = "latest"
            }
            admin_username = "azureuser"
            admin_password = "Azureuser@1234"
        },
        "Myweb" = {
            size = "Standard_B1s"
            disable_password_authentication = false
            os_disk = {
                caching = "ReadWrite"
                storage_account_type = "Standard_LRS"
            }
            source_image_reference = {
                publisher = "Canonical"
                offer = "0001-com-ubuntu-server-jammy"
                sku = "22_04-lts"
                version = "latest"
            }
            admin_username = "azureuser"
            admin_password = "Azureuser@1234"
        }
    }   
}

# variable for Private Subnet VMs
variable "private_vm"{
    type = map(object({
        size = string
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
        admin_username = string
        admin_password = string
    }))
    default = {
        "Mydb" = {
            size = "Standard_B1s"
            disable_password_authentication = false
            os_disk = {
                caching = "ReadWrite"
                storage_account_type = "Standard_LRS"
            }
            source_image_reference = {
                publisher = "Canonical"
                offer = "0001-com-ubuntu-server-jammy"
                sku = "22_04-lts"
                version = "latest"
            }
            admin_username = "azureuser"
            admin_password = "Azureuser@1234"
        }
    }
}