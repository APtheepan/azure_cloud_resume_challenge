resource "azurerm_cdn_profile" "websiteCDN" {
  name                = "websiteCDN"
  resource_group_name = azurerm_resource_group.rg_website.name
  location            = azurerm_resource_group.rg_website.location
  sku                 = "Standard_Microsoft"
}


resource "azurerm_cdn_endpoint" "websiteCDNEndpoint" {
  name                = "websiteCDNEndpoint"
  profile_name        = azurerm_cdn_profile.websiteCDN.name
  location            = azurerm_resource_group.rg_website.location
  resource_group_name = azurerm_resource_group.rg_website.name
  origin {
    name                = "websiteCDNOrigin"
    host_name           = azurerm_storage_account.website-storage-acc.primary_web_host
    http_port           = 80
    https_port          = 443 
  }
}

