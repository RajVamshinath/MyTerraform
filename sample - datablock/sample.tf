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

data "azurerm_resource_group" "rg"{
    name = "RG2"    
}

resource "azurerm_virtual_network" "vnet" {
    name = "myVnet"
    address_space = ["10.0.0.0/16"]
    location = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
}