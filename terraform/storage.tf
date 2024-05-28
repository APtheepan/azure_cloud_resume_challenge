

resource "azurerm_storage_account" "website-storage-acc" {
  name                     = "websitestorageaccsap"
  resource_group_name      = azurerm_resource_group.rg_website.name
  location                 = azurerm_resource_group.rg_website.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document = "resume.html"
  }
}
resource "azurerm_storage_blob" "resume_blob" {
  name                   = "resume.html"
  storage_account_name   = azurerm_storage_account.website-storage-acc.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "/home/theepan/cloud_resume_challenge/frontend/resume.html"
}
resource "azurerm_storage_blob" "css" {
  name                   = "resume.css"
  storage_account_name   = azurerm_storage_account.website-storage-acc.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "/home/theepan/cloud_resume_challenge/frontend/resume.css"
  content_type           = "text/css"
}