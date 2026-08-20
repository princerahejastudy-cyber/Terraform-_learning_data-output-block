terraform {
  required_providers {
    azurerm = {

      source  = "hashicorp/azurerm"
      version = "~> 4.0"

    }

  }


  # backend "azurerm" {
  #   resource_group_name  = "kml_rg_main-cc8983c1ffff4cd9"
  #   storage_account_name = "prince123456789"
  #   container_name       = "prince123456789"
  #   key                  = "terraform.tfstate"
  # }
}


provider "azurerm" {

  features {}
  resource_provider_registrations = "none"

}
