

module "rgroup" {
  source = "./rgroup"
  name   = "N01469295-assignment1-RG"
  location = "eastus"
}

module "network" {
  source                = "./network"
  vnet_name             = "N01469295-vnet"
  vnet_address_space    = ["10.0.0.0/16"]
  subnet_name           = "N01469295-subnet"
  subnet_address_prefixes = ["10.0.1.0/24"]
  location              = "eastus"
  subnet_id = module.network.subnet_id
  resource_group_name   = module.rgroup.rg_name
  dns_zone        = "N01469295-assignment1.com"
}

module "common" {
  source              = "./common"
  law_name            = "N01469295-law"
  rsv_name            = "N01469295-rsv"
  sa_name             = "n01469295commonsa"
  location            = "eastus"
  resource_group_name = module.rgroup.rg_name
}

module "vmlinux" {
source  = "./vmlinux"
  vm_count = 2

  subnet_id                      = module.network.subnet_id
  location                       = "eastus"
  resource_group_name            = module.rgroup.rg_name
  admin_username                 = "Ganesh"
  custom_data                    = "#cloud-config\nhostname: N01469295-linux-1\nfqdn: N01469295-linux-1.eastus.cloudapp.azure.com\n"
  ssh_key                        = "C:\\Users\\ganes\\.ssh\\id_rsa.pub"
  ssh_private_key                = "C:\\Users\\ganes\\.ssh\\id_rsa"
  log_analytics_workspace_id     = module.common.log_analytics_workspace_id
  log_analytics_workspace_resource_id = module.common.log_analytics_workspace_resource_id
}

module "vmwindows" {
  source                = "./vmwindows"
  resource_prefix       = "N01469295-vmwindows"
  location              = "eastus"
  resource_group_name   = module.rgroup.rg_name
  subnet_id             = module.network.subnet_id
  vm_size               = "Standard_B1ms"
  admin_username        = "Ganesh"
  admin_password        = "P@ssw0rd1234"
  domain_name_label     = "mywinsvm"
  dns_zone              = "mydomain.com"
  tags                  = {
    Project         = "Automation Project - Assignment 1"
    Name            = "Ganesh.Thampi"
    ExpirationDate  = "2023-06-30"
    Environment     = "Lab"
  }
}


module "datadisk" {
  source              = "./datadisk"
  location            = "eastus"
  resource_group_name = module.rgroup.rg_name
  vm_names            = ["N01469295-linux-1", "N01469295-linux-2", "windows-vm"]
  tags                  = {
    Project         = "Automation Project - Assignment 1"
    Name            = "Ganesh.Thampi"
    ExpirationDate  = "2023-06-30"
    Environment     = "Lab"
  }
}


