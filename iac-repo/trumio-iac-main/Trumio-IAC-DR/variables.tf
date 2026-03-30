
#Local variables
variable "client" {
    description = "Defines client name"
    default     = "cl"
}

variable "deploy_app_service" {
  type        = bool
  default     = true
}
variable "tf_state" {
    description = "Defines terraform state file resource group"
    default     = "azusctr-uat-rg"
    #default     = "vijay-rg"
}
variable "org" {
    description = "Defines organization name"
    default     = "tr"
}
variable "env" {
    description = "Defines environment name"
    default     = "tru"
}

variable "region" {
  description = "resource deployment region"
  default     = "cus"
}

variable "ins_count" {
  description = "Defines instance count"
  default     = "03"
}

variable "location" {
    description = "Location of the resource group"
    default      = "Central US"
}


#Resource group variables

variable "rg_tags" {
    description = "Tags for the resource group"
    type        = map(string)
    default = {
    app = "Prod-DR-APP"
    }
}

#Virtual Network & subnet variables

variable "vnet_address_prefix" {
    description = "Address prefix for the vnet"
    type        = list(string)
    default = ["10.29.0.0/21"]
    }

variable "subnets" {
    description = "List of subnets within the vnet"
    type        = map(any)
    default = {
      subnet1 = {
        name = "aks-dr-snet"
        address_prefix = ["10.29.0.0/22"]
    }
     subnet2 = {
        name = "appgw-dr-snet"
        address_prefix = ["10.29.6.0/27"]
    }
     subnet3 = {
        name = "ts-dr-snet"
        address_prefix = ["10.29.7.0/26"]
    }
     subnet4 = {
        name = "pvtep-dr-snet"
        address_prefix = ["10.29.6.64/27"]
    }
     subnet5 = {
        name = "GatewaySubnet"
        address_prefix = ["10.29.7.224/27"]
    }
     subnet6 = {
        name = "flexi-dr-subnet"
        address_prefix = ["10.29.4.0/27"]
    }
  }
}

variable "vnet_tags" {
    description = "Tags for the vnet"
    type        = map(string)
    default = {
    app = "Prod-DR-APP"
    }
}


#PublicIP variables

variable "app_gw_pip_tags" {
  description = "Tags for the Public IP address of the Application Gateway"
  type        = map(string)
  default = {
    app = "Prod-DR-APP"
    }
}

#Terminal server Win-VM variables

variable "storage_account_name" {
  type = string
  default = "terraformsastatefile"
  #default = "terraformtrialsa"
}

variable "storage_account_key" {
  type = string
  default = "7SHtDgbnfQm0KCzTL0Rx3nz77j17FOSKQA2uXxGL/1RRhP23q9JgakGu92PUbAVFeNlD5STz/qGj+AStJEbupw=="
  #default = "ZcW5iO8/1xTaBlas+SIW4niQtoE/fbGkUMBLARMytJrtHCwu0cpxkXIaGG6hb9czxhjY7GNAeX2y+AStGIjIbA=="
}

variable "container_name" {
  type = string
  default = "shellscript"
}
variable "vm_wts_size" {
  description = "vm size"
  type = list(string)
  default = [ "Standard_E2as_v5", "Standard_D2s_v3", "Standard_E8as_v5" ]
}

variable "vm_wts_adm_usr" {
  description = "vm terminal server admin username"
  default     = "trumiotruuser"
}

variable "vm_wts_adm_pwd" {
  description = "vm terminal server admin password"
  default     = "T#k@!bA_&#$@5WvrV1M"
}

variable "vm_wts_image_publisher" {
  description = "windows vm terminal server image publisher"
  type = list(string)
  default = ["MicrosoftWindowsServer", "MicrosoftWindowsDesktop"]
}

variable "vm_wts_image_offer" {
  description = "windows vm terminal server image offer"
  type = list(string)
  default = [ "WindowsServer", "Windows-11", "Windows-10"  ]
}

variable "vm_wts_image_sku" {
  description = "vm sku for terminal server"
  type = list(string)
  default = [ "2022-Datacenter", "2019-Datacenter", "win11-22h2-ent","win10-22h2-ent"  ]
}

#Linux VM variables

# variable "vm_ls_size" {
#   description = "vm size"
#   type = list(string)
#   default = [ "Standard_E2as_v5", "Standard_D2s_v3" ]
# }


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

variable "storage_config" {
  description = "Configuration for storage accounts."
  type = map(object({
    #random_id = string
    cors_rule = list(object({
      allowed_origins     = optional(list(string), null)
      allowed_methods     = optional(list(string), null)
      allowed_headers     = optional(list(string), null)
      exposed_headers     = optional(list(string), null)
      max_age_in_seconds  = optional(number, null)
    }))
    static_website_config = list(object({
      index_document       = optional(string, null)
      error_404_document   = optional(string, null)
    }))
    containers           = optional(map(object({
      name                 = optional(string, null)
      container_access_type = optional(string, null)
    })))
  }))

  default = {
    storage_account1 = {
      #random_id = random_id.storage_account[0].hex      
      cors_rule = [{
        allowed_origins     = ["https://prod-tru-app.trumio.ai"]
        allowed_methods     = ["GET", "PUT"]
        allowed_headers     = ["*"]
        exposed_headers     = ["content-length"]
        max_age_in_seconds = 200
      }]
      containers = {
        "container1" = {
          name                 = "trumio-private"
          container_access_type = "private"
        }
        "container2" = {
          name                 = "trumio-public"
          container_access_type = "blob"
        }
      }
      static_website_config = []
    },
    storage_account2 = {
      #random_id = random_id.storage_account[1].hex
      cors_rule = []
      static_website_config = [{
        index_document       = "index.html"
        error_404_document   = "error.html"
      }]
      containers = {}
    }
  }
}


variable "sa_tags" {
    description = "Tags for the storage account"
    type        = map(string)
    default = {
    app = "Prod-DR-APP"
    }
}


#ACR variables

variable "acr_sku" {
    description = "Azure container registry sku"
    default     = "Premium"
}

variable "acr_pvt_dns_name" {
    description = "Azure private dns zone name"
    default     = "privatelink.azurecr.io" 
}

variable "acr_tags" {
    description = "Tags for the vnet"
    type        = map(string)
    default = {
    app = "Prod-DR-APP"
    }
}


# AKS variables

variable "aks_kubernetes_version" {
  description = "AKS cluster kubernetes version"
  default     = "1.28.9"
}

variable "aks_sku" {
    description = "Azure kubernetes cluster sku"
    default     =  "Premium"  
}

# System nodepool

variable "aks_sysnp_node_count" {
  description = "AKS cluster system node pool count"
  default     = 1
}

variable "aks_sysnp_min_count" {
  description = "AKS cluster system node pool min count"
  default     = 1
}

variable "aks_sysnp_max_count" {
  description = "AKS cluster system node pool max count"
  default     = 3
}

variable "aks_sysnp_max_pods" {
  description = "AKS cluster system node pool max pods"
  default     = 30
}
variable "aks_sysnp_vm_size" {
  description = "AKS cluster system np vm size"
  type = list(string)
  default = [ "Standard_F4s_v2", "Standard_F2s_v2", "Standard_D8as_v5" ]   
}

variable "aks_sysnp_os_disk_size_gb" {
  description = "AKS cluster system np os disk size gb"
  type = list(string)
  default = [ "32", "64" ]   
}

variable "aks_sysnp_os_disk_type" {
  description = "AKS cluster system node pool OS disk type"
  default     = "Managed"
}

variable "aks_sysnp_os_sku" {
  description = "AKS cluster system node pool OS SKU"
  default     = "Ubuntu"
}

variable "aks_sysnp_node_labels" {
  description = "AKS cluster system node pool node labels"
  default     = {
    workload = "system"
  }
}


# User nodepool

variable "aks_usrnp_names" {
  description = "Name of the first user node pool"
  type        = list(string)
  default     = [ "trusrdrnp02", "trghadrnp02" ]
}

variable "aks_usrnp_node_count" {
  description = "AKS cluster user node pool count"
  default     = 1
}

variable "aks_usrnp_min_count" {
  description = "AKS cluster user node pool min count"
  default     = 1
}

variable "aks_usrnp_max_count" {
  description = "AKS cluster user node pool max count"
  default     = 3
}

variable "aks_usrnp_max_pods" {
  description = "AKS cluster user node pool max pods"
  default     = 30
}

variable "aks_usrnp_vm_sizes" {
  description = "AKS cluster user np vm size"
  type = list(string)
  default = [ "Standard_D2as_v5", "Standard_F4s_v2", "Standard_D8as_v5" ]   
}


variable "aks_usrnp_os_disk_size_gb" {
  description = "AKS cluster user np os disk size gb"
  type = list(string)
  default = [ "32", "64" ] 
}

variable "aks_usrnp_os_disk_type" {
  description = "AKS cluster user node pool OS disk type"
  default     = "Managed"
}

variable "aks_usrnp_os_sku" {
  description = "AKS cluster user node pool OS SKU"
  default     = "Ubuntu"
}

variable "aks_usrnp_node_labels" {
  description = "AKS cluster user node pool node labels"
  default     = {
    workload = "prod"
  }
}

##Keyvault variables
variable "keyvault_sku_name" {
  description = "SKU name for Key Vault"
  type = list(string)
  default = [ "standard", "premium" ] 
}

variable "soft_delete_retention_days" {
  description = "Soft delete retention period in days for Key Vault"
  type = list(string)
  default = [ "15", "30" ] 
}

variable "secrets" {
  description = "A map of secrets to be stored in the Key Vault."
  type        = map(string)
  default     = {
    "JwtSecret"                         = "b400d2a11cace649e7180d99872df5fe1e522dc7ab4ebe943aa1e5d0f6d92fc8"
    "AppVersion"                        = "1.0.0"
    "DocUsername"                       = "admin&turMio725"
    "DocPassword"                       = "truMio*815_jkd"
    "MongoUri"                          = "mongodb+srv://trumio-user:hLH43QpWzFUE2xos@trumiocluster0.ckrj5.mongodb.net/trumio-prod?retryWrites=true&w=majority"
    "GoogleClientId"                    = "1079858550340-dn5uh2dhnv4lta9je2hdh6mu6jabmqdu.apps.googleusercontent.com"
    "AzureStorageConnectionString"      = "DefaultEndpointsProtocol=https;AccountName=azusctrstgacc;AccountKey=Fuz5x2UpS1M5sVeeyZ7NfGSp64IBuD9D9C7Gy1aZYFLvOgOHmxcgPbGOkNgoutfsRUpW49LgfcHK+AStyOK6kQ==;EndpointSuffix=core.windows.net;"
    "AzurePublicBlobContainerName"      = "trumio-public"
    "AzurePrivateBlobContainerName"     = "trumio-private"
    "TwilioAccountSid"                  = "AC2cfac41cf4c21f5bb42f6f0a087c22f9"
    "TwilioAuthToken"                   = "d6d3064a7a662b0d837aa8e5ce7c0d84"
    "TwilioMessagingServiceSid"         = "MGa524cbff19019c81abb3f7df335dcd9d"
    "FirebaseType"                      = "service_account"
    "FirebaseProjectId"                 = "trumio-inc"
    "FirebasePrivateKeyId"              = "8e73b08431f344bab8df2c0de4b7aa3448ecafa9"
    "FirebasePrivateKey"                = "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDBV3lhvUSu9W6B\nHLWX9f3uWTia6qyNLkFni4jrlODFc6iBpClV/IP4Rf1w3McbUCXjchSDwD9xOpyt\nnH34MBMbS1S3BPmn6lLH7avvgJLMEmUG5Na8qvSDPVUMZRh9B8xFa0ZwlxemJXmo\nPTd83JEHJWsZ1HMK2lLt5+EZ+NWIvNOJNtdHUB6RumT3KQdhtQHTDSDLWfy3nof0\n/E/jqxh6lkVEsrqkZ7gyFVYZkVCYzh9BwpTVm2rxUiYLf/azdpmXnxNy5WO8mms9\n4VMhZe8PW4e8SXybM3+AWh4syMxEmebFo95jbGtyuuFLynWAikv55y2xH553ToVC\nu/Cxx1s9AgMBAAECggEAGJUjbxC2VKuKlRp+IVfq5T0NZC8d6OZ+dOiqLE/1400h\nGfiyM8djTTQy9QBxRXEDnD9zScwuFNq/tJhO8PlF2KTTnOCiUJ4Lz/VRdOaLY6yc\nEUwT3JG8/JnWADkza6RL7fClmGexn1Oo/AHqlfLicr7odvSK+xCG1k5zEc8QcW3e\nNoLFc8qxs6eEhliGSDiHvKe6iaR4XiJSVNExMFJTlyi2PA8LUBmNimG6g/qrDbSZ\nYYrfLwjoCUT9xuATmLJyUuy3Y9CiUtaBNa33t4+xFP0uoINb8ueiSx9VBtD+7NdG\nJzxUPp+0zLYWIn1tpncGVAvBcuEbjvkR1iCQjTxdoQKBgQDnUCiSnElff0g/i4l7\nJzgThqaENKN6+BmuGofSVI5vQ63Jy0f9ScIYvLKsM12eet1EqBvidfk3I7Rw0ufn\nDpCS8gk+NllduEtRmYmK5D3b2IiTttmHWsoIbzmsMZvPsJIn96jso+dOihHDooC6\neSs3pDTMihPidJl0HeiCnyn6nQKBgQDV+eBJNof4vAh4ygXw1gJhqX9n/RoXpV5b\ncVqVdd+MtmNZ5POGu72it5NgdY+rUN2kaN857C1PYOuUVkyT4RT4AQVWRrkSwnv/\nxqOD9UEQKNB2De60Evqi9Atbiq+WNZl/wzCMItSxfcoX2EKfLL1RfCqA1pkgmaA8\nS3RQ/h4xIQKBgECmYcCgV82OGJZSHKnEC2NBtharU6nR3/OOTLnXkju80bzdyRAc\n5lfdnZ6NeLQLqP5AchK4YGAt5YfHGrO0mWnIphayQAX2tW5oGE4ufq+MdJe8ek3f\nbSowVBExiFfjBOaQzLDfGo4T/uUL7SixJwgVKACm8unPJviSR2MCs0vtAoGAGkeb\nLUK+RmVJoRQm0KJoHniDxlDGkJrl0NNGLc8RSqXn49WDt0t9ieuD9TfbEk5XOmcK\n64E/O12K8Wf79bmSKrdtYWBEQLKUKiDKWl2XxRVOLQGfDIy8LaFNd8u7rvYcSR2+\n66cnejkZxf3wiL4k7koSqkow+lkD3gPiYEQljyECgYEAvCNjw7PhwBYSSoygw/Mc\nHYd51iWoi6NSSPo4/v4laZxu00cQu79k84PfOYcOAO1PLiqwa84/clgqnHn6IXfb\nmcbpszhysgesKSvAiqBRYeMRIeFLXGdW0RuHPGK4krjV9niLTLuzRcyIikMZ29Dp\ncc9/gx69Fc9XNFLPX/7dkSo=\n-----END PRIVATE KEY-----\n"
    "FirebaseClientEmail"               = "firebase-adminsdk-vplfg@trumio-inc.iam.gserviceaccount.com"
    "FirebaseClientId"                  = "118303656551340745425"
    "FirebaseAuthUri"                   = "https://accounts.google.com/o/oauth2/auth"
    "FirebaseTokenUri"                  = "https://oauth2.googleapis.com/token"
    "FirebaseAuthProviderX509CertUrl"   = "https://www.googleapis.com/oauth2/v1/certs"
    "FirebaseClientX509CertUrl"         = "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-vplfg%40trumio-inc.iam.gserviceaccount.com"
    "FirebaseUniverseDomain"            = "googleapis.com"
    "CometAppId"                        = "241690c8766bd7a9"
    "CometChatRegion"                   = "us"
    "CometChatApiKey"                   = "6c90ac8db0951d4b2d4d1fcc4fe359843cc991f2"
    "StripeApiKey"                      = "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"
    "StripeMainEndpointSecret"          = "whsec_RkitpfY5WvY5w2AJ5Er4dmuzAvYniLSm"
    "StripeConnectEndpointSecret"       = "whsec_GRv5oYVvbsPAbMwMznNdlGo4SK6xP1Ph"
    "OpenaiApiKey"                      = "5e8e5250683343ba88fdc03725aab517"
    "DataServiceUrl"                    = "https://api.trumio.ai/user"
    "OpenaiBaseUrl"                     = "https://trumio-uat-openai.openai.azure.com/"
    "OpenaiApiType"                     = "azure"
    "OpenaiApiVersion"                  = "2023-08-01-preview"
    "LlmDeploymentId"                   = "UAT-Deployment"
    "LlmModelVendor"                    = "azure"
    "AccessTokenValidity"               = "1440"
    "RefreshTokenValidity"              = "2880"
    "ResetPasswordTokenValidity"        = "5"
    "GenerateDeepLinkValidity"          = "60"
    "ReferralInvitationValidity"        = "60"
    "LoginRetryCount"                   = "5"
    "AdminFrontend"                     = "https://admin-app.trumio.ai"
  }
}


## Application gateway variables
variable "app_gw_sku_name" {
  description = "SKU name for the Application Gateway"
  type        = list(string)
  default = ["Standard_v2", "WAF_v2"]
}

variable "app_gw_sku_tier" {
  description = "SKU tier for the Application Gateway"
  type        = list(string)
  default     = ["Standard_v2", "WAF_v2"] 
}

variable "app_gw_ip_config_name" {
  description = "Name of IP configuration for the Application Gateway"
  type        = string
  default     = "appgw_ipconfig" 
}

variable "waf_configuration" {
  description = "waf_configuration block"
  type        = map(object({
    enabled          = bool
    firewall_mode    = string
    rule_set_version = string
  }))
  default = {
    "waf1" = {
    enabled          = true
    firewall_mode    = "Detection"
    rule_set_version = "3.0"
    }
  }
}
variable "backend_address_pool" {
  description = "backend_address_pool block"
  type        = map(object({
    name = string
    ip_addresses = list(string)
  }))
  default = {
    "pool1" = {
      name = "tr-aks-bp"
      ip_addresses = ["20.163.159.39"]
    },
    "pool2" = {
      name = "tr-admin-bp"
      ip_addresses = ["74.226.161.38"]
    }
    "pool3" = {
      name = "tr-sa-bp"
      ip_addresses = ["74.226.161.38"]
    }
  }
}

variable "backend_http_settings" {
  description = " backend http settings  block"
  type        = map(object({
      name                  = string
      cookie_based_affinity = string
      port                  = number
      protocol              = string
      request_timeout       = number
    }))
    default = {
      "backend_setting1" = {
        name                  = "tr-aks-bs"
        cookie_based_affinity = "Disabled"
        port                  = 80
        protocol              = "Http"
        request_timeout       = 90
        host_name             = "uat-prm-api.trumio.ai"
      },
      "backend_setting2" = {
        name                  = "tr-admin-bs"
        cookie_based_affinity = "Disabled"
        port                  = 80
        protocol              = "Http"
        request_timeout       = 90
        host_name             = "admin-app-uat-prm.trumio.ai"
      }
      "backend_setting3" = {
        name                  = "tr-sa-bs"
        cookie_based_affinity = "Disabled"
        port                  = 443
        protocol              = "Https"
        request_timeout       = 90
        host_name             = "trsaprodcusc9a8b8e8.blob.core.windows.net"
      }
    }
}

variable "ssl_certificate_name" {
  type        = string
  default     = "trumio-PFX"
}
variable "http_listener" {
  description = "http listener block"
  type        = map(object({
    name      = string
    protocol  = string
    host_name = string
    frontend_port_name = string
    ssl_certificate_name  = string
  }))
  default = {
    "listener1" = {
            name                    = "tr-aks-ls"
            protocol                = "Https"
            host_name               = "uat-prm-api.trumio.ai"
            frontend_port_name      = "443"
            ssl_certificate_name    = "trumio-PFX"
          },
          "listener2" = {
            name                    = "tr-admin-ls"
            protocol                = "Https"
            host_name               = "admin-app-uat-prm.trumio.ai"
            frontend_port_name      = "443"
            ssl_certificate_name    = "trumio-PFX"
          }
       }
}


variable "request_routing_rule" {
  description = "request routing rule block"
  type        = map(object({
   name                         = string
   priority                     = string
   rule_type                    = string
    http_listener_name          = string
    backend_address_pool_name   = string
    backend_http_settings_name  = string
  }))
  default = {
    "routing_rule1" = {
      name                        = "tr-aks-rule"
      priority                    = "1"
      rule_type                   = "Basic"
      http_listener_name          = "tr-aks-ls"
      backend_address_pool_name   = "tr-aks-bp"
      backend_http_settings_name  = "tr-aks-bs"
    }
    "routing_rule2" = {
      name                        = "tr-admin-rule"
      priority                    = "2"
      rule_type                   = "Basic"
      http_listener_name          = "tr-admin-ls"
      backend_address_pool_name   = "tr-admin-bp"
      backend_http_settings_name  = "tr-admin-bs"
    }
  }
}

variable "probes" {
  description = "probe block"
  type        = map(object({
      name                  = string
      protocol              = string
      path                  = string
      interval              = number
      timeout               = number
      unhealthy_threshold   = number
  }))
  default = {
    "probe1" = {
        name                  = "tr-aks-probe"
        protocol              = "Http"
        path                  = "/user/health-check"
        interval              = 60
        timeout               = 60
        unhealthy_threshold   = 3
      }
    "probe2" = {
        name                  = "tr-admin-probe"
        protocol              = "Http"
        path                  = "/"
        interval              = 60
        timeout               = 60
        unhealthy_threshold   = 3
      }
    "probe3" = {
        name                  = "tr-sa-probe"
        protocol              = "Https"
        path                  = "/trumio-public/for-health-probe-dnd/12.jpg"
        interval              = 60
        timeout               = 60
        unhealthy_threshold   = 3
      }
  }
}


## Flexible server

variable "admin_login" {
  description = "Administrator login for the MySQL Flexible Server"
  default     = "trumiouser"
}

variable "admin_password" {
  description = "Administrator password for the MySQL Flexible Server"
  default     = "DSwq$#jNQ"
}

variable "flexible_server_pvt_dns_name" {
  description = "Name of the Private DNS zone for the MySQL Flexible Server"
  default     = "tr-flexi-prod-cus.mysql.database.azure.com"
}

variable "sku_name" {
  description = "SKU name for the MySQL Flexible Server"
  default     = "B_Standard_B1s"
}

variable "mysql_version" {
  description = "MySQL version for the MySQL Flexible Server"
  default     = "8.0.21"
}

variable "db_name" {
  description = "DB name for the MySQL Flexible Server"
  default     = "trumio-mb"
}

#Frontdoor & CDN variables

variable "front_door_sku_name" {
  description = "The SKU name of the Azure CDN Front Door profile."
  type        = list(string)
  default = [ "Standard_AzureFrontDoor", "Premium_AzureFrontDoor" ]
}


##App service variables

variable "asp_sku" {
  description = "SKU of the App Service Plan."
  type        = list(string)
  default     = ["F1", "B1", "B2"]
}

variable "token" {
  type        = string
  description = "Access token of source gitHub repository"
  default     = "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"
}

variable "repo_url" {
  description = "Github repository URL"
  type        = string
  default     = "https://github.com/trumio/trumio-iac.git"
}

variable "repo_branch" {
  description = "Github repository branch"
  type        = string
  default     = "application"
}


# Azure Automation account variables
variable "auto_sku" {
  description = "SKU Type"
  type        = string
  default = "Free"
}

variable "auto_tags" {
    description = "Tags for the automation account"
    type        = map(string)
    default = {
    app = "Prod-DR-APP"
    }
}


### Virtual network gateway

variable "vnet_gw_type" {
  description = "virtual network gateway type"
  default = ["Vpn","ExpressRoute"]
}

variable "vnet_gw_vpn_type" {
  description = "virtual network gateway vpn type"
  default = ["RouteBased","PolicyBased"]
}

variable "vnet_gw_sku" {
  description = "virtual network gateway sku"
  default = ["Basic","Standard","HighPerformance","UltraPerformance","ErGw1AZ","ErGw2AZ","ErGw3AZ","VpnGw1", "VpnGw2", "VpnGw3", "VpnGw4","VpnGw5", "VpnGw1AZ", "VpnGw2AZ", "VpnGw3AZ","VpnGw4AZ", "VpnGw5AZ"] 
}

# recovery service vault

variable "rsv_sku" {
  description = "Recovery service vault sku"
  default = "Standard"
}

##OpenAI variables

variable "opi_sku" {
  description = "SKU for the Azure Cognitive Account"
  type        = string
  default     = "S0"
}

variable "opi_location" {
  description = "Location for the Azure Cognitive Account"
  type        = string
  default     = "East US"
}

variable "opi_tags" {
  description = "Tags for the Azure Cognitive Account"
  type        = map(string)
  default = {
    app = "DR-OpenAI"
    }
}

variable "deployments" {
  description = "Map of deployment configurations"
  type        = map(any)
  default = {
      deployment1 = {
        name = "DR-Deployment1"
            model = {
              name    = "gpt-35-turbo-16k"
              version = "0613"
    }
  }
      deployment2 = {
        name = "DR-Deployment2"
            model = {
              name    = "gpt-35-turbo-16k"
              version = "0613"
        }
      }
    }
 }