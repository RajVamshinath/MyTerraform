# create a resource group
resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.resource_group_location
}

# create a virtual network
resource "azurerm_virtual_network" "vnet"{
    name = var.virtual_network_name
    address_space = var.virtual_network_address_prefixes
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
}

# creation of public subnets
resource "azurerm_subnet" "subnet_public"{
    for_each = var.subnet_public_CIDR
    name = each.key
    address_prefixes = [each.value]
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
}

# creation of private subnets - db
resource "azurerm_subnet" "subnet_private_db"{
    name = var.subnet_private_db
    address_prefixes = var.subnet_private_db_CIDR
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
}

