terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "=4.1.0"
        }
    }
}
provider "azurerm" {
    features {} 
    subscription_id = "4c4a9b0e-3bf8-4ea2-a4d2-2fa272a13539"
}

module "azurerm_virtual_network" {
    source = "./Modules_VMcompute"
    resource_group_name = "myResourceGroup"
    resource_group_location = "East US" 
    virtual_network_name = "myVnet"
    virtual_network_address_prefixes = ["10.0.0.0/24"]
}

module "azurerm_subnet" {
    source = "./Modules_VMcompute/"
    subnet_address_prefixes = ["10.0.0.0/28"]
    depends_on = [module.azurerm_virtual_network]  
}