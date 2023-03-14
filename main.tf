module "rgroup" {
  source     = "./rgroup"
  humber_id  = "n9295"
  location   = "East US" # Replace with the desired Azure region
  tags = {
    Project        = "Automation Project – Assignment 1"
    Name           = "Ganesh.Thampi"
    ExpirationDate = "2023-06-30"
    Environment    = "Lab"
  }
}

module "network" {
  source             = "./network"
  humber_id          = "n9295"
  resource_group_name = module.rgroup.resource_group_name
  location           = "East US" # Replace with the desired Azure region
  tags = {
    Project        = "Automation Project – Assignment 1"
    Name           = "Ganesh.Thampi"
    ExpirationDate = "2023-06-30"
    Environment    = "Lab"
  }
}

module "common" {
  source             = "./common"
  humber_id          = "n9295"
  resource_group_name = module.rgroup.resource_group_name
  location           = "East US" # Replace with the desired Azure region
  tags = {
    Project        = "Automation Project – Assignment 1"
    Name           = "Ganesh.Thampi"
    ExpirationDate = "2023-06-30"
    Environment    = "Lab"
  }
}

module "vmlinux" {
  source             = "./vmlinux"
  humber_id          = "n9295"
  resource_group_name = module.rgroup.resource_group_name
  location           = "East US" # Replace with the desired Azure region
  subnet_id          = module.network.subnet_id
  storage_account_primary_blob_endpoint = module.common.storage_account_primary_blob_endpoint
  ssh_key                        = "C:\\Users\\ganes\\.ssh\\id_rsa.pub"
  ssh_private_key                = "C:\\Users\\ganes\\.ssh\\id_rsa"
  admin_username                 = "Ganesh"
  tags = {
    Project        = "Automation Project – Assignment 1"
    Name           = "Ganesh.Thampi"
    ExpirationDate = "2023-06-30"
    Environment    = "Lab"
  }
}


module "vmwindows" {
  source             = "./vmwindows"
  humber_id          = "n9295"
  resource_group_name = module.rgroup.resource_group_name
  location           = "East US" # Replace with the desired Azure region
  subnet_id          = module.network.subnet_id
  storage_account_primary_blob_endpoint = module.common.storage_account_primary_blob_endpoint
  tags = {
    Project        = "Automation Project – Assignment 1"
    Name           = "Ganesh.Thampi"
    ExpirationDate = "2023-06-30"
    Environment    = "Lab"
  }
}

module "datadisk" {
  source             = "./datadisk"
  humber_id          = "n9295"
  resource_group_name = module.rgroup.resource_group_name
  location           = "East US" # Replace with the desired Azure region
  vm_ids = module.vmlinux.vm_ids
  
}

module "loadbalancer" {
  source             = "./loadbalancer"
  humber_id          = "n9295"
  resource_group_name = module.rgroup.resource_group_name
  location           = "East US" # Replace with the desired Azure region
  public_ip_address_ids = module.vmlinux.public_ip_address_ids
  linux_vm_nic_ids   = module.vmlinux.vm_nic_ids
  
}

module "database" {
  source             = "./database"
  humber_id          = "n9295"
  resource_group_name = module.rgroup.resource_group_name
  location           = "East US" # Replace with the desired Azure region
}





