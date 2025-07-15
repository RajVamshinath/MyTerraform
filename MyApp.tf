module "Vnet"{
    source = "./Modules/Vnet-tf"
}

module "VMs"{
    source = "./Modules/VMs-tf"
}