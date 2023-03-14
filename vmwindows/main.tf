resource "azurerm_network_interface" "vmwindows_nic" {
  name                = "${var.resource_prefix}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.resource_prefix}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vmwindows_public_ip.id
  }

  tags = var.tags
}

resource "azurerm_virtual_machine" "vmwindows" {
  name                  = "windows-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vmwindows_nic.id]
  vm_size               = var.vm_size


  storage_os_disk {
    name              = "${var.resource_prefix}-winosdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "windows-vm"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
  }

  
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  tags = var.tags
}

resource "azurerm_public_ip" "vmwindows_public_ip" {
  name                = "${var.resource_prefix}-public-ip"
  location            = "eastus"
  resource_group_name = "N01469295-assignment1-RG"
  allocation_method   = "Dynamic"
  domain_name_label   = var.domain_name_label

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "vmwindows_antimalware_extension" {
  name                  = "${var.resource_prefix}-antimalware"
  virtual_machine_id    = azurerm_virtual_machine.vmwindows.id
  publisher             = "Microsoft.Azure.Security"
  type                  = "IaaSAntimalware"
  type_handler_version  = "1.7"
  auto_upgrade_minor_version = true

  protected_settings = <<PROTECTED_SETTINGS
    {
        "AntimalwareEnabled": true,
        "RealtimeProtectionEnabled": true
    }
PROTECTED_SETTINGS

  settings = <<SETTINGS
    {
        "AntimalwareEnabled": true,
        "RealtimeProtectionEnabled": true,
        "ScheduledScanSettings": {
            "isEnabled": false,
            "day": "7",
            "time": "120",
            "scanType": "Quick",
            "isRecurring": true
        }
    }
SETTINGS

  tags = var.tags
}