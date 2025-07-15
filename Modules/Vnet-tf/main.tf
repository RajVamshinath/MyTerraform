# create a resource group
resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.resource_group_location
}

# create a virtual network
resource "azurerm_virtual_network" "vnet"{
    name = "${var.virtual_network_name}vnet-tf"
    address_space = var.virtual_network_address_prefixes
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
}

# creation a subnets
resource "azurerm_subnet" "subnet"{
    name = "${var.virtual_network_name}subnet-tf"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = var.subnet_address_prefixes
}

# creation of network security groups
resource "azurerm_network_security_group" "nsg" {
    name = "${var.virtual_network_name}nsg-tf"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule{
        name = "AllowAppTraffic"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "8080"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }
}

# associate subnets with network security groups
resource "azurerm_subnet_network_security_group_association" "nsg-association"{
    subnet_id = azurerm_subnet.subnet.id
    network_security_group_id = azurerm_network_security_group.nsg.id
}