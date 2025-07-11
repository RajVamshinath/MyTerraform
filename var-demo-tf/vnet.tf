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
    name = "${each.key}-subnet-tf"
    address_prefixes = [each.value]
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
}

# creation of private subnets - db
resource "azurerm_subnet" "subnet_private"{
    for_each = var.subnet_private_CIDR
    name = "${each.key}-subnet-tf"
    address_prefixes = [each.value]
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
}

# creation of network security groups for public subnets
resource "azurerm_network_security_group" "nsg_public" {
    for_each = var.subnet_public_CIDR
    name = "${each.key}-nsg-tf"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule{
        name = var.nsg_public_security_rules[each.key].name
        priority = var.nsg_public_security_rules[each.key].priority
        direction = var.nsg_public_security_rules[each.key].direction
        access = var.nsg_public_security_rules[each.key].access
        protocol = var.nsg_public_security_rules[each.key].protocol
        source_port_range = var.nsg_public_security_rules[each.key].source_port_range
        destination_port_range = var.nsg_public_security_rules[each.key].destination_port_range
        source_address_prefix = var.nsg_public_security_rules[each.key].source_address_prefix
        destination_address_prefix = var.nsg_public_security_rules[each.key].destination_address_prefix 
    }
}

# creation of network security groups for private subnets
resource "azurerm_network_security_group" "nsg_private"{
    for_each = var.subnet_private_CIDR
    name = "${each.key}-nsg-tf"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule{
        name = var.nsg_private_security_rules[each.key].name    
        priority = var.nsg_private_security_rules[each.key].priority
        direction = var.nsg_private_security_rules[each.key].direction
        access = var.nsg_private_security_rules[each.key].access
        protocol = var.nsg_private_security_rules[each.key].protocol
        source_port_range = var.nsg_private_security_rules[each.key].source_port_range
        destination_port_range = var.nsg_private_security_rules[each.key].destination_port_range
        source_address_prefix = var.nsg_private_security_rules[each.key].source_address_prefix
        destination_address_prefix = var.nsg_private_security_rules[each.key].destination_address_prefix
    }
}

# associate public subnets with their respective NSGs
resource "azurerm_subnet_network_security_group_association" "public_subnet_NSG_association"{
    for_each =  var.subnet_public_CIDR
    subnet_id = azurerm_subnet.subnet_public[each.key].id
    network_security_group_id = azurerm_network_security_group.nsg_public[each.key].id
}

# associate private subnets with their respective NSGs
resource "azurerm_subnet_network_security_group_association" "private_subnet_NSG_association"{
    for_each =  var.subnet_private_CIDR
    subnet_id = azurerm_subnet.subnet_private[each.key].id
    network_security_group_id = azurerm_network_security_group.nsg_private[each.key].id
}

# creation of NAT gateway
resource "azurerm_nat_gateway" "nat-private_subnet"{
    name = var.NAT_gateway_name
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
}

# creation of public IP for NAT gateway
resource "azurerm_public_ip" "NAT_public_IP"{
    name = var.NAT_publicIP
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    allocation_method = var.NAT_publicIP_allocation_method
}

# association of NAT gateway with publicIP
resource "azurerm_nat_gateway_public_ip_association" "NAT_publicIP_association"{
    nat_gateway_id = azurerm_nat_gateway.nat-private_subnet.id
    public_ip_address_id = azurerm_public_ip.NAT_public_IP.id
}

# associate NAT with private subnets
resource "azurerm_subnet_nat_gateway_association" "nat_private_subnet_association"{
    for_each = var.subnet_private_CIDR
    subnet_id = azurerm_subnet.subnet_private[each.key].id
    nat_gateway_id = azurerm_nat_gateway.nat-private_subnet.id
}
