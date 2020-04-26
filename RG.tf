provider "AzureRm" {
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
Location
