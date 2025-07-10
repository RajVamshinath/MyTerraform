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
        "Myappsubnet-tf" = "10.0.0.1/28",
        "Mywebsubnet-tf" = "10.0.0.15/28"
    }
}

# variable for private subnet name - db
variable "subnet_private_db"{
    type = string
    default = "Mysubnetdb-tf"
}

# variable for private subnet CIDR - db
variable "subnet_private_db_CIDR"{
    type = list(string)
    default = ["10.0.0.32/24"]
}