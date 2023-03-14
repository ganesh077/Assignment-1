resource "azurerm_availability_set" "availability_set" {
  name                = "N01469295-as"
  location            = var.location
  resource_group_name = var.resource_group_name
  managed             = true
}

resource "azurerm_public_ip" "public_ip" {
  count               = var.vm_count
  name                = "N01469295-linux-${count.index+1}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"

  tags = {
    Project        = "Automation Project – Assignment 1"
    Name           = "Ganesh.Thampi"
    ExpirationDate = "2023-06-30"
    Environment    = "Lab"
  }
}

resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = "N01469295-linux-${count.index+1}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }
}

resource "azurerm_virtual_machine" "vm" {
  count               = var.vm_count
  name                = "N01469295-linux-${count.index+1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  availability_set_id = azurerm_availability_set.availability_set.id
  vm_size = "Standard_B1ms"

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_5"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-${count.index+1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "N01469295-linux-${count.index+1}"
    admin_username = var.admin_username

    custom_data = base64encode(var.custom_data)
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = file(var.ssh_key)

    }
  }

  network_interface_ids = [azurerm_network_interface.nic[count.index].id]

  delete_os_disk_on_termination = true

provisioner "remote-exec" {
    inline = [
    "hostname"
    ]
    connection {
  host        = azurerm_public_ip.public_ip[count.index].ip_address
  type        = "ssh"
  user        = var.admin_username
  private_key = file(var.ssh_private_key)
}

}

 depends_on = [
    azurerm_network_interface.nic,
    azurerm_public_ip.public_ip,
  ]
}



resource "random_string" "vm_dns_label" {
count = var.vm_count
length = 8
upper = false
numeric = true
special = false
min_upper = 0
min_numeric = 0
}

resource "azurerm_network_security_group" "nsg" {
count = var.vm_count
name = "N01469295-linux-${count.index+1}-nsg"
location = var.location
resource_group_name = var.resource_group_name

security_rule {
  name                       = "SSH"
  priority                   = 1001
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
count = var.vm_count
network_interface_id = azurerm_network_interface.nic[count.index].id
network_security_group_id = azurerm_network_security_group.nsg[count.index].id
}

resource "azurerm_virtual_machine_extension" "vm_extension" {
count = var.vm_count
name = "N01469295-linux-${count.index+1}-vmext"
virtual_machine_id = azurerm_virtual_machine.vm[count.index].id
publisher = "Microsoft.Azure.NetworkWatcher"
type = "NetworkWatcherAgentLinux"
type_handler_version = "1.4"
auto_upgrade_minor_version = true

protected_settings = jsonencode({
  "workspaceId" = var.log_analytics_workspace_id
})

settings = jsonencode({
  "workspaceResourceId" = var.log_analytics_workspace_resource_id
})

}




