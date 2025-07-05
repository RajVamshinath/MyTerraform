# create a resource group
resource "azurerm_resource_group" "rg" {
    name = "Myrg-tf"
    location = "East US"
}

# create a virtual network
resource "azurerm_virtual_network" "vnet"{
    name = "Myvnet-tf"
    location = "azurerm_resource_group.rg.location"
    resource_group_name = "azurerm_resource_group.rg.name"
    address_space = ["10.0.0.0/24"]
}


