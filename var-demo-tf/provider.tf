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
    subscription_id = "a2a9f784-eb09-4959-9e93-bd058c5daff1"
}