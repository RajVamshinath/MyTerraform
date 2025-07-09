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

# variable for Vnet name and CIDRs
variable "vnet_name_CIDR"{
    type = map(string)
    default = {
        "vnet_name" = "Myvnet-tf",
        "vnet_CIDR" = "10.0.0.0/24"
    }
}


