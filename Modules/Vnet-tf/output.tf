output "subnet" {
    value = azurerm_subnet.subnet.id
}

output "network_security_group" {
    value = azurerm_network_security_group.nsg.id
}