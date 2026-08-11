terraform {
  required_providers {
    azurerm = {

      source  = "hashicorp/azurerm"
      version = "~> 4.0"

    }

  }


  backend "azurerm" {
    resource_group_name  = "kml_rg_main-c5539f4fa20649b3"
    storage_account_name = "prince123456789"
    container_name       = "prince123456789"
    key                  = "terraform.tfstate"
  }
}


provider "azurerm" {

  features {}
  resource_provider_registrations = "none"

}
