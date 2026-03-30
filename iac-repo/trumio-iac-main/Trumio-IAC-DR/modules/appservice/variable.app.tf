variable "asp_name" {
  type        = string
  description = "Name of the Azure App Service Plan."
}

variable "asp_rg_location" {
  type        = string
  description = "Location for the App Service Plan."
}

variable "asp_rg_name" {
  type        = string
  description = "Resource group for the App Service Plan."
}

variable "asp_sku" {
  type        = string
  description = "SKU name for the App Service Plan."
}

variable "webapp_name" {
  type        = string
  description = "Name of the Azure Web App."
}

variable "webapp_rg_location" {
  type        = string
  description = "Location of the Web App."
}

variable "webapp_rg_name" {
  type        = string
  description = "Resource group name of the Web App."
}

variable "token" {
  type        = string
  description = "Access token name of source gitHub repository"
}


variable "repo_url" {
  type        = string
  description = "URL of source code gitHub repository"
}

variable "repo_branch" {
  type        = string
  description = "Branch of the GitHub repository "
}
