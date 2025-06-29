output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "api_management_gateway_url" {
  description = "API Management 게이트웨이의 URL"
  value       = azurerm_api_management.apim.gateway_url
}

output "openai_endpoints" {
  description = "생성된 Azure OpenAI 서비스들의 엔드포인트"
  value = {
    for key, service in azurerm_cognitive_account.aoai :
    key => service.endpoint
  }
}

