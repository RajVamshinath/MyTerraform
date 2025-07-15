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
    source = "./Modules"
}

module "azurerm_linux_virtual_machine" {
    source = "./Modules" 
}