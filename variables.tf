variable "resource_group_name" {
  description = "리소스 그룹의 이름"
  type        = string
  default     = "rg-apim-aoai-prod-001"
}

variable "location" {
  description = "리소스가 배포될 Azure 지역"
  type        = string
  default     = "East US"
}

variable "apim_name" {
  description = "API Management 인스턴스의 이름"
  type        = string
  default     = "tdg-apim-zb-prod-202506"
}

variable "apim_publisher_name" {
  description = "APIM 게시자 이름"
  type        = string
  default     = "ZEROBIG"
}

variable "apim_publisher_email" {
  description = "APIM 게시자 이메일"
  type        = string
  default     = "zerobig.kim@gmail.com"
}

variable "apim_sku_name" {
  description = "APIM의 SKU. (예: Developer_1, Basic_1, Standard_1, Premium_1)"
  type        = string
  default     = "Developer_1"
}

# 2개의 Azure OpenAI 서비스 및 모델 배포 정보를 맵(map) 형태로 정의
variable "openai_services" {
  description = "배포할 Azure OpenAI 서비스 및 모델 목록"
  type = map(object({
    name          = string
    location      = string
    sku_name      = string
    model_name    = string
    model_version = string
    deployment_name = string
  }))
  default = {
    "aoai_eastus" = {
      name            = "tdg-aoai-zb-koreacental-202506"
      location        = "East US"
      sku_name        = "S0"
      model_name      = "gpt-4o"
      model_version   = "2024-08-06"
      deployment_name = "gpt-4o"
    },
    "aoai_westus" = {
      name            = "tdg-aoai-zb-japaneast-202506"
      location        = "West US"
      sku_name        = "S0"
      model_name      = "gpt-4o"
      model_version   = "2024-08-06"
      deployment_name = "gpt-4o"
    }
  }
}
