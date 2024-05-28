output "static_website_url" {
  value = azurerm_storage_account.website-storage-acc.primary_web_endpoint
}