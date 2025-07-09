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
variable "virtual_network"{
    type = map(string)
    default = {
        name = "Myvnet-tf"
        address_prefixes = ["10.0.0.0/24"]
    }
}

