# Terraform 및 Azure Provider 설정
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 리소스 그룹 생성
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# API Management 인스턴스 생성
resource "azurerm_api_management" "apim" {
  name                = var.apim_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = var.apim_publisher_name
  publisher_email     = var.apim_publisher_email
  sku_name            = var.apim_sku_name
}

# 2개의 Azure OpenAI 서비스 생성 (for_each 사용)
resource "azurerm_cognitive_account" "aoai" {
  for_each = var.openai_services

  name                = each.value.name
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "OpenAI"
  sku_name            = each.value.sku_name
}

# 2개의 gpt-4o 모델 배포 (for_each 사용)
resource "azurerm_cognitive_deployment" "aoai_deployment" {
  for_each = var.openai_services

  name                 = each.value.deployment_name
  cognitive_account_id = azurerm_cognitive_account.aoai[each.key].id

  model {
    format  = "OpenAI"
    name    = each.value.model_name
    version = each.value.model_version
  }

  scale {
    type = "Standard"
  }
}

