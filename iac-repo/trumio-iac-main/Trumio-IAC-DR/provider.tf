terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.96.0"
    }
  }
backend "azurerm" {
    # resource_group_name  = "vijay-rg"
    # storage_account_name = "terraformtrialsa"
    # container_name       = "tfstate"
    # key                  = "trumioiac.tfstate"
    # tenant_id            = "24917450-fe15-4414-92ed-94fa8ec1b938"  #Test
    # subscription_id      = "4560a661-0d5e-40fc-a13a-fa8fbedae3f3"  #Test
    
    resource_group_name  = "azusctr-uat-rg"
    storage_account_name = "terraformsastatefile"
    container_name       = "tfstate"
    key                  = "trumioiac1.tfstate"
    tenant_id            = "0e80e407-b720-49ad-9d55-6820f8d14bc2"
    subscription_id      = "b983da0b-033c-4c43-b7b2-eb5e4a976343"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = "true"
  # subscription_id            = "4560a661-0d5e-40fc-a13a-fa8fbedae3f3"
  # tenant_id                  = "24917450-fe15-4414-92ed-94fa8ec1b938"
  # client_id                  = "fe900c2c-d11e-4d49-b33e-b08d64ea1bc4"  # Test sub client id
  subscription_id            = "b983da0b-033c-4c43-b7b2-eb5e4a976343"
  tenant_id                  = "0e80e407-b720-49ad-9d55-6820f8d14bc2"
  client_id                  = "bdc0043c-b4da-4ecc-aebb-87008ba85cb5"
  client_secret              = "qsI8Q~X9tivjnqdgzfr~FBxEKFa6I4RDQoJ7zbJz" 
  features {}
}

