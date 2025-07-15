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

# variable for subnet address prefixes
variable "subnet_address_prefixes"{       
    type = list(string)
    default = ["10.0.0.0/28"]
}