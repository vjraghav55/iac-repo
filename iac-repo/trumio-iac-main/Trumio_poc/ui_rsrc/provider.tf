terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.92.0"
    }
  }
  
backend "azurerm" {
    resource_group_name  = "azusctr-uat-rg"
    storage_account_name = "terraformsastatefile"
    container_name       = "tfstate"
    key                  = "trumioiac.tfstate"
    tenant_id            = "0e80e407-b720-49ad-9d55-6820f8d14bc2"
    subscription_id      = "b983da0b-033c-4c43-b7b2-eb5e4a976343"
  }
}


# Configure the Microsoft Azure Provider
provider "azurerm" {
    skip_provider_registration  = "true"
    client_id                   = "bdc0043c-b4da-4ecc-aebb-87008ba85cb5"
    client_secret               = "aC98Q~fzjNIuZlftIqr5oIcqA5PVvyTfgtJTvaX0"
    subscription_id             = "b983da0b-033c-4c43-b7b2-eb5e4a976343"
    tenant_id                   = "0e80e407-b720-49ad-9d55-6820f8d14bc2"
  features {}
}

