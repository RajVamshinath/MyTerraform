# create a resource group
resource "azurerm_resource_group" "rg" {
    name = "Myrg-tf"
    location = "East US"
}

# create a virtual network
resource "azurerm_virtual_network" "vnet"{
    name = "Myvnet-tf"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space = ["10.0.0.0/24"]
}

# creation a subnets
resource "azurerm_subnet" "subnet-app"{
    name = "Myappsubnet-tf"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.0.0/28"]
}

resource "azurerm_subnet" "subnet-web"{
    name = "Mywebsubnet-tf"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.0.16/28"]
}

resource "azurerm_subnet" "subnet-db"{
    name = "Mydbsubnet-tf"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.0.32/28"]
}

