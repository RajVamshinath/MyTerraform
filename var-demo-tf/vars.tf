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
        "Myappsubnet-tf" = "10.0.0.0/28",
        "Mywebsubnet-tf" = "10.0.0.16/28"
    }
}

# variable for private subnet name - db
variable "subnet_private_CIDR"{
    type = map(string)
    default = {
        "Mydbsubnet-tf" = "10.0.0.48/28"
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
        "Myappsubnet-tf" = {
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
        "Mydbsubnet-tf" = {
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
}

# variable for Private NICs - IPConfig
variable "private_nic"{
    type = map(object({
        name = string
        private_ip_address_allocation = string
    }))
}
