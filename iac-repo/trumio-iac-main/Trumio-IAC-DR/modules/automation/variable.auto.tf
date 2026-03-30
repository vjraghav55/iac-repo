#Automation Account variables
variable "auto_name" {
    description = "Automation account name"
}

variable "auto_location" {
    description = "Automation account location"
}

variable "auto_rg_name" {
    description = "Automation account resource group name"
}

variable "auto_sku" {
    description = "Automation account sku"
}

variable "auto_tags" {
    description = "Automation account tags"
}

variable "auto_scope" {
    description = "Automation account identity scope"
}


###Runbook Variables###
variable "runbook_location" {
    description = "Automation account runbook location"
}

variable "runbook_rg" {
    description = "Automation account runbook rg"
}

variable "runbook1_name" {
    description = "Automation account runbook1 name"
}

variable "runbook2_name" {
    description = "Automation account runbook2 name"
}

###Automation Schedule###
variable "schedule1_name" {
    description = "Automation account schedule1 name"
}

variable "schedule2_name" {
    description = "Automation account schedule2 name"
}