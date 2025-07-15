resource "azurerm_subnet" "subnet-app" {
    name = "subnet-app"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = var.subnet_address_prefixes
}