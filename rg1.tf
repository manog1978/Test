provider "azureRm" {
    version= "~>2.0"
    subscription_id = "770967bf-10a3-406c-9113-e840e22c7e5a caf6e094-0249-4665-a5b2-8cc7839041bf"
}

#Creation Resouce Group
resource "azurerm_resource_group" "mygroup" {
    name = "TeraRG"
    Location = "southindia"
    Tags = { 
        environment = "Test"
    }
}

# create the Virtual network
resource "azurerm_virtual_network" "myvnet"  {
    name = "myvnetwork"
    resource_group_name = "azurerm_resource_group.mygroup.name"
    address_space = "10.0.0.0/16"
    location = "${azurerm_resource_group.mygroup.location}" 
    
}
# create the subnet
resource "azurerm_subnet" "mysubnet"
name = "aclvnet"
resource_group_name = "azurerm_resource_group.mygroup.name"
virtual_network_name = ""azurerm_virtual_network.myvnet.myvnetwork"
address prefix = "10.0.0.0/12"
}

# create storage account
resource "azurerm_storage_account" "aci-sa" {
  name                = "acisa"
  resource_group_name  = "azurerm_resource_group.mygroup.name"
  location            = "azurerm_resource_group.mygroup.location"
  account_tier        = "Standard"

  account_replication_type = "LRS"
}
resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = "azurerm_resource_group.mygroup.location"
  resource_group_name   = "azurerm_resource_group.mygroup.name"
  vm_size               = "Standard_DS1_v2"

storage_image_reference {
    publisher = "Microsoftwindowsserver"
    offer     = "WindowsServer"
    sku       = "windows 2012"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  
  tags = {
    environment = "staging"
  }
}