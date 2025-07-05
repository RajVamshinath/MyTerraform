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

# creation of network security groups
resource "azurerm_network_security_group" "nsg-app" {
    name = "Myappnsg-tf"
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

resource "azurerm_network_security_group" "nsg-web" {
    name = "Mywebnsg-tf"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule{
        name = "AllowWebTraffic"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "80"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }
}

resource "azurerm_network_security_group" "nsg-db" {
    name = "Mydbnsg-tf"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule{
        name = "AllowDbTraffic"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "5432"
        source_address_prefix = "10.0.0.0/24"
        destination_address_prefix = "10.0.0.0/24"
    }
}

# associate subnets with network security groups
resource "azurerm_subnet_network_security_group_association" "nsg-app-association"{
    subnet_id = azurerm_subnet.subnet-app.id
    network_security_group_id = azurerm_network_security_group.nsg-app.id
}

resource "azurerm_subnet_network_security_group_association" "nsg-web-association"{
    subnet_id = azurerm_subnet.subnet-web.id
    network_security_group_id = azurerm_network_security_group.nsg-web.id
}

resource "azurerm_subnet_network_security_group_association" "nsg-db-association"{
    subnet_id = azurerm_subnet.subnet-db.id
    network_security_group_id = azurerm_network_security_group.nsg-db.id
}

# creation of NAT gateway
resource azurerm_nat_gateway "nat-db"{
    name = "natgateway-db-tf"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
}






