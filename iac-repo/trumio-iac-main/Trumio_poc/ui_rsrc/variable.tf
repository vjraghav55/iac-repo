#Local variables

variable "rsc_grp_name" {
    description = "Defines resource group name"
    default     = "trumio"
}

variable "storage_account_deploy" {
  type    = bool
  default = false
}

variable "openai_deploy" {
  type    = bool
  default = true
}

variable "textanalytics_deploy" {
  type    = bool
  default = true
}

variable "faceapi_deploy" {
  type    = bool
  default = true
}

variable "computervision_deploy" {
  type    = bool
  default = true
}

variable "app_service_deploy" {
  type        = bool
  default     = false
}

variable "tf_state" {
    description = "Defines terraform state file resource group"
    #default     = "trumio-tf-rg"
     default     = "azusctr-uat-rg"
}

variable "org" {
    description = "Defines organization name"
    default     = "tru"
}
variable "env" {
    description = "Defines environment name"
    default     = "prod"
}

variable "region" {
  description = "resource deployment region"
  default     = "ncus"
}

variable "ins_count" {
  description = "Defines instance count"
  default     = "01"
}

variable "location" {
    description = "Location of the resource group"
    default     = "North Central US"
}



##client invite

#variable "user_invitations" {
 # description = "Map of user invitations"
  #type        = map(any)
#}

variable "client_name" {
  description = "Name of client"
  type        = string
  default     = "trumio"
}  
variable "client_email_address" {
  description = "Email address of client"
  type        = string
  default     = "client1@gmail.com"
}  
variable "client_type" {
  description = "Client access type"
  type        = string
  default     = "Guest"
} 



#Resource group variables

variable "rg_tags" {
    description = "Tags for the resource group"
    type        = map(string)
    default = {
    app = "OpenAI"
    }
}

#Virtual Network & subnet variables

variable "vnet_address_prefix" {
    description = "Address prefix for the vnet"
    type        = list(string)
    default = ["10.30.0.0/21"]
    }

variable "subnets" {
    description = "List of subnets within the vnet"
    type        = map(any)
    default = {
      subnet1 = {
        name = "openai-snet"
        address_prefix = ["10.30.0.0/22"]
    }

  }
}

variable "vnet_tags" {
    description = "Tags for the vnet"
    type        = map(string)
    default = {
    app = "OpenAI"
    }
}

##roleassignment
variable "contrib_role" {
  description = "Role definition to assign for users"
  type        = list(string)
  default     = ["Contributor", "Cost Management Reader"]
}

variable "owner_role" {
  description = "Role definition to assign for client"
  type        = string
  default     = "Owner"
}



#Storage account variables

variable "sa_account_tier" {
    description = "Storage account tier"
    type = list(string)
    default = [ "Standard", "Premium" ]   
}

variable "sa_account_kind" {
    description = "Storage account kind"
    type = list(string)
    default = [ "BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2" ]   
}

variable "sa_access_tier" {
    description = "Storage access tier"
    type = list(string)
    default = [ "Hot", "Cool" ]   
}

variable "sa_account_replication_type" {
    description = "Replication type of storage account"
    type = list(string)
    default = [ "LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS" ]    
}

variable "containers" {
    description = "container details"
    type        = map(any)
    default     = {
      "container1" = {
            name                  = "trumio-openai-private"
            container_access_type = "private"
      }
      "container2" = {
            name                  = "trumio-openai-public"
            container_access_type = "blob"
      }
    }
}

variable "sa_tags" {
    description = "Tags for the storage account"
    type        = map(string)
    default = {
    app = "OpenAI"
    }
}

##OpenAI variables

variable "opi_sku" {
  description = "SKU for the Azure Cognitive Account"
  type        = string
  default     = "S0"
}

variable "opi_tags" {
  description = "Tags for the Azure Cognitive Account"
  type        = map(string)
  default = {
    app = "OpenAI"
    }
}

# variable "deployments" {
#   description = "Map of deployment configurations"
#   type        = map(any)
#   default = {
#       deployment1 = {
#         name = "PROD-Deployment1"
#             model = {
#               name    = "gpt-35-turbo-16k"
#               version = "0613"
#     }
#   }
#       deployment2 = {
#         name = "PROD-Deployment2"
#             model = {
#               name    = "gpt-35-turbo-16k"
#               version = "0613"
#         }
#       }
#     }
#  }

variable "opi_deploy_name" {
  description = "Name of deployment configurations"
  type        = string
  default     = "Deployment1"
}

variable "openai_model_name" {
  description = "Name of deployment model"
  type        = string
  default     = "gpt-35-turbo-16k"
}

variable "openai_model_version" {
  description = "Deployment model version"
  type        = string
  default     = "0613"
}

## Text Analytics variables

variable "ta_sku" {
  description = "SKU for the Azure Text Analytics Account"
  type        = string
  default     = "S"
}

variable "ta_tags" {
  description = "Tags for the Azure Text Analytics Account"
  type        = map(string)
  default = {
    app = "TextAnalytics"
  }
}

# variable "ta_deploy_name" {
#   description = "Name of deployment configurations"
#   type        = string
#   default     = "TextAnalyticsDeployment"
# }

# variable "analytics_model_name" {
#   description = "Name of deployment model"
#   type        = string
#   default     = "text-analytics-model"
# }

# variable "analytics_model_version" {
#   description = "Deployment model version"
#   type        = string
#   default     = "1.0"
# }

# ## Face API variables

variable "faceapi_sku" {
  description = "SKU for the Azure Face API Account"
  type        = string
  default     = "S0"
}

variable "facepi_tags" {
  description = "Tags for the Azure Face API Account"
  type        = map(string)
  default = {
    app = "FaceAPI"
  }
}

# variable "faceapi_deploy_name" {
#   description = "Name of deployment configurations"
#   type        = string
#   default     = "FaceAPIDeployment"
# }

# variable "face_model_name" {
#   description = "Name of deployment model"
#   type        = string
#   default     = "face-api-model"
# }

# variable "face_model_version" {
#   description = "Deployment model version"
#   type        = string
#   default     = "1.0"
# }

# ## Computer Vision variables

variable "vision_sku" {
  description = "SKU for the Azure Custom Vision Account"
  type        = string
  default     = "S1"
}

variable "vision_tags" {
  description = "Tags for the Azure Custom Vision Account"
  type        = map(string)
  default = {
    app = "CustomVision"
  }
}

# variable "vision_deploy_name" {
#   description = "Name of deployment configurations"
#   type        = string
#   default     = "CustomVisionDeployment"
# }

# variable "vision_model_name" {
#   description = "Name of deployment model"
#   type        = string
#   default     = "custom-vision-model"
# }

# variable "vision_model_version" {
#   description = "Deployment model version"
#   type        = string
#   default     = "1.0"
# }

##App service variables

variable "asp_sku" {
  description = "SKU of the App Service Plan."
  type        = list(string)
  default     = ["F1", "B1", "B2"]
}

# variable "token" {
#  type        = string
#   description = "Access token of source gitHub repository"
#   default     = "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"
# }

# variable "repo_url" {
#  description = "Github repository URL"
#   type        = string
#   default     = "https://github.com/trumio/trumio-iac.git"
# }

# variable "repo_branch" {
#  description = "Github repository branch"
#   type        = string
#   default     = "application"
# }
