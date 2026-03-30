#------------------data source----------------

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.tf_state
}

#----------------local variable--------------

locals {
  client                 = var.client
  deploy_app_service     = var.deploy_app_service
  default_tags = {
    env = "dr",
    biz = "Operation"
    Team = "Operations"
  }
}

#-----------Resource-group module-------------

module "resource_group" {
  source         = "./modules/rg"
  rg_name        = "${var.org}-rg-${var.env}-${var.region}-${var.ins_count}"
  rg_location    = var.location
  rg_tags        = merge(local.default_tags, var.rg_tags)
}

#-----------Virtual Network module------------

module "vnet" {
  source                     = "./modules/vnet"
  vnet_name                  = "${var.org}-vnet-${var.env}-${var.region}-${var.ins_count}"
  vnet_location              = module.resource_group.rg_location
  vnet_rg_name               = module.resource_group.rg_name
  vnet_address_prefix        = var.vnet_address_prefix
  vnet_tags                  = merge(local.default_tags, var.vnet_tags)
  subnets                    = var.subnets
}


#--------------Public IP---------------------

module "publicip" {
  source = "./modules/pip"
  app_gw_pip_name        = "${var.org}-appgw-pip-${var.env}-${var.region}-${var.ins_count}"
  app_gw_pip_rg_name     = module.resource_group.rg_name
  app_gw_pip_location    = module.resource_group.rg_location
  app_gw_pip_tags        = merge(local.default_tags, var.app_gw_pip_tags)
}


#----------------Virtual machine --------------------
module "vm" {
  source = "./modules/vm"

  # WTS PIP
  # public_ip_wts_name       = "${var.org}-wts-pip-${var.env}-${var.region}-${var.ins_count}"
  # public_ip_wts_location   = module.resource_group.rg_location
  # public_ip_wts_rg_name    = module.resource_group.rg_name

  # WTS NSG
  nsg_wts_name       = "${var.org}-wts-nsg-${var.env}-${var.region}-${var.ins_count}"
  nsg_wts_location   = module.resource_group.rg_location
  nsg_wts_rg_name    = module.resource_group.rg_name
  nsg_wts_tags       = local.default_tags

  # WTS NIC
  nic_wts_name       = "${var.org}-wts-nic-${var.env}-${var.region}-${var.ins_count}"
  nic_wts_location   = module.resource_group.rg_location
  nic_wts_rg_name    = module.resource_group.rg_name
  nic_wts_tags       = local.default_tags
  nic_wts_snet_id    = module.vnet.subnet_id.subnet3


  # Win-VM
  storage_account_name   = var.storage_account_name
  storage_account_key    = var.storage_account_key
  container_name         = var.container_name
  vm_wts_name            = "${var.org}-ts-${var.region}-${var.ins_count}"
  vm_wts_location        = module.resource_group.rg_location
  vm_wts_rg_name         = module.resource_group.rg_name
  vm_wts_size            = var.vm_wts_size[2]
  vm_wts_adm_usr         = var.vm_wts_adm_usr
  vm_wts_adm_pwd         = var.vm_wts_adm_pwd
  vm_wts_image_publisher = var.vm_wts_image_publisher[0]
  vm_wts_image_offer     = var.vm_wts_image_offer[0]
  vm_wts_image_sku       = var.vm_wts_image_sku[0]
  vm_wts_tags            = local.default_tags

  # Lin-VM

   #LS NSG
  # nsg_ls_name        = "${var.org}-ls-nsg-${var.env}-${var.region}-${var.ins_count}"
  # nsg_ls_location    = module.resource_group.rg_location
  # nsg_ls_rg_name     = module.resource_group.rg_name
  # nsg_ls_tags        = local.default_tags

  #   # LS NIC
  # nic_ls_name        = "${var.org}-ls-nic-${var.env}-${var.region}-${var.ins_count}"
  # nic_ls_location    = module.resource_group.rg_location
  # nic_ls_rg_name     = module.resource_group.rg_name
  # nic_ls_tags        = local.default_tags
  # nic_ls_snet_id     = module.vnet.subnet_id.subnet3

  # vm_ls_name            = "${var.org}-webvm-${var.env}-${var.region}-${var.ins_count}"
  # vm_ls_rg_location     = module.resource_group.rg_location
  # vm_ls_rg_name         = module.resource_group.rg_name
  # vm_ls_size            = var.vm_ls_size[0]
  # vm_ls_tags            = local.default_tags
}

#--------------Service bus---------------

module "service_bus" {
  source                      = "./modules/servicebus"
  svcbus_name                 = "${var.org}-svcbus-${var.env}-${var.region}-${var.ins_count}"
  svcbus_rg                   = module.resource_group.rg_name
  svcbus_location             = module.resource_group.rg_location 
  svcbus_topic                = "${var.org}-svcbustopic-${var.env}-${var.region}-${var.ins_count}"
}

#--------------Event grid topic----------------
module "evgtopic" {
  source                      = "./modules/eventgridtopic"
  evgtopic_name                 = "${var.org}-evgtopic-${var.env}-${var.region}-${var.ins_count}"
  evgtopic_rg                   = module.resource_group.rg_name
  evgtopic_location             = module.resource_group.rg_location   
}


#---------Storage account module------------
resource "random_id" "storage_account" {
for_each   = var.storage_config
  byte_length = 4
}

module "storage_account" {
   for_each                    = var.storage_config
   source                      = "./modules/sa"
   sa_name                     = "${var.org}sa${var.env}${var.region}${lower(random_id.storage_account[each.key].hex)}"
   sa_rg_name                  = module.resource_group.rg_name
   sa_location                 = module.resource_group.rg_location
   sa_account_tier             = var.sa_account_tier[0]
   sa_account_kind             = var.sa_account_kind[4]
   sa_access_tier              = var.sa_access_tier[0]
   sa_account_replication_type = var.sa_account_replication_type[0]
   sa_tags                     = merge(local.default_tags, var.sa_tags)
   cors_rule                   = each.value.cors_rule
   static_website_config       = each.value.static_website_config
   containers                  = each.value.containers
 
  }

#--------------ACR module-------------------

module "acr" {
  source            = "./modules/acr"
  acr_name          = "${var.org}acr${var.env}${var.region}${var.ins_count}"
  acr_rg_name       = module.resource_group.rg_name
  acr_location      = module.resource_group.rg_location
  acr_sku           = var.acr_sku
  acr_tags          = merge(local.default_tags, var.acr_tags)
  
#ACR Private dns
  acr_pvt_dns_name   = var.acr_pvt_dns_name
  acr_pvt_dns_vlink  = module.vnet.vnet_name
  acr_vnet_id        = module.vnet.vnet_id
  acr_subnet_id      = module.vnet.subnet_id.subnet4
 

#ACR Private endpoint
  acr_pep_name       = "${var.org}-acr-pep-${var.env}-${var.region}-${var.ins_count}"

#ACR Private service connection
  acr_psvc_name      = "${var.org}-acr-psvc-${var.env}-${var.region}-${var.ins_count}"
  acr_pdns_zone_gp   = "${var.org}-acr-pdnszg-${var.env}-${var.region}-${var.ins_count}"

}

#----------------AKS module-------------------

module "aks" {
  source                    = "./modules/aks"
  aks_name                  = "${var.org}-k8s-${var.env}-${var.region}-${var.ins_count}"
  aks_location              = module.resource_group.rg_location
  aks_rg_name               = module.resource_group.rg_name
  aks_dns_prefix            = "${var.org}-${var.env}-k8s-app-${var.region}-${var.ins_count}-dns"
  aks_kubernetes_version    = var.aks_kubernetes_version
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  aks_sku                   = var.aks_sku

  #System nodepool details
  aks_sysnp_name             = "${var.org}sysdrnp${var.ins_count}"
  aks_sysnp_node_count       = var.aks_sysnp_node_count
  aks_sysnp_min_count        = var.aks_sysnp_min_count
  aks_sysnp_max_count        = var.aks_sysnp_max_count
  aks_sysnp_max_pods         = var.aks_sysnp_max_pods
  aks_sysnp_vm_size          = var.aks_sysnp_vm_size[2]
  aks_sysnp_os_disk_size_gb  = var.aks_sysnp_os_disk_size_gb[1]
  aks_sysnp_os_disk_type     = var.aks_sysnp_os_disk_type
  aks_sysnp_os_sku           = var.aks_sysnp_os_sku
  aks_sysnp_vnet_subnet_id   = module.vnet.subnet_id.subnet1
  aks_sysnp_node_labels      = var.aks_sysnp_node_labels
  aks_sysnp_tags             = local.default_tags

  # User nodepool details
  aks_usrnp_names            = var.aks_usrnp_names
  aks_usrnp_node_count       = var.aks_usrnp_node_count
  aks_usrnp_min_count        = var.aks_usrnp_min_count
  aks_usrnp_max_count        = var.aks_usrnp_max_count
  aks_usrnp_max_pods         = var.aks_usrnp_max_pods
  aks_usrnp_vm_sizes         = var.aks_usrnp_vm_sizes[2]
  aks_usrnp_os_disk_size_gb  = var.aks_usrnp_os_disk_size_gb[1]
  aks_usrnp_os_disk_type     = var.aks_usrnp_os_disk_type
  aks_usrnp_os_sku           = var.aks_usrnp_os_sku
  aks_usrnp_vnet_subnet_id   = module.vnet.subnet_id.subnet1
  aks_usrnp_node_labels      = var.aks_usrnp_node_labels
  aks_usrnp_tags             = local.default_tags
}

#----------------User Identity---------------------------
 module "user_identity" {
   source                       = "./modules/useridentity"
   user_identity_appgw_location = module.resource_group.rg_location
   user_identity_appgw_name     = "${var.org}-ui-${var.env}-${var.region}-${var.ins_count}"
   user_identity_appgw_rg_name  = module.resource_group.rg_name
 }

/*
#-----------------Keyvault-----------------------------
module "keyvault" {
  source                       = "./modules/keyvault"
  keyvault_name                = "${var.org}-akv-${var.env}-${var.region}-${var.ins_count}"
  keyvault_location            = module.resource_group.rg_location
  keyvault_resource_group_name = module.resource_group.rg_name
  keyvault_sku_name            = var.keyvault_sku_name[0]
  soft_delete_retention_days   = var.soft_delete_retention_days[1]
  tenant_id                    = data.azurerm_client_config.current.tenant_id
  object_ids                   = [
    data.azurerm_client_config.current.object_id,
    module.user_identity.user_identity_principal_id
  ]
  secrets                      = var.secrets
  depends_on                   = [ module.user_identity ]
}
*/

#----------------Application Gateway----------------

module "app_gateway" {
  source                     = "./modules/appgw"
  app_gw_name                = "${var.org}-appgw-${var.env}-${var.region}-${var.ins_count}"
  app_gw_rg_name             = module.resource_group.rg_name 
  app_gw_location            = module.resource_group.rg_location
  app_gw_sku_name            = var.app_gw_sku_name[1]
  app_gw_sku_tier            = var.app_gw_sku_tier[1]
  app_gw_ip_config_name      = var.app_gw_ip_config_name
  app_gw_subnet_id           = module.vnet.subnet_id["subnet2"]
  app_gw_frontend_ip_name    = module.publicip.public_name
  app_gw_ip_address_id       = module.publicip.public_id
  app_gw_user_identity_id    = [module.user_identity.user_id]
  waf_configuration          = var.waf_configuration
  backend_address_pool       = var.backend_address_pool
  backend_http_settings      = var.backend_http_settings
  ssl_certificate_name       = var.ssl_certificate_name
  http_listener              = var.http_listener
  request_routing_rule       = var.request_routing_rule
  probes                     = var.probes
  depends_on                 = [
    module.resource_group,
    module.vnet,
    module.publicip,
    module.user_identity
  ]
}

/*
#------------Flexible server-----------
 module "mysql_flexible_server" {
  source                        = "./modules/flexiserver"
  flexible_server_name          = "${var.org}-flexi-${var.env}-${var.region}-${var.ins_count}"
  flexible_server_rg_name       = module.resource_group.rg_name
  flexible_server_location      = module.resource_group.rg_location
  admin_login                   = var.admin_login
  admin_password                = var.admin_password
  flexible_server_vnet_id       = module.vnet.vnet_id
  flexible_server_subnet_id     = module.vnet.subnet_id.subnet6  
  flexible_server_pvt_dns_name  = "${var.org}-flexi-${var.env}-${var.region}.mysql.database.azure.com"
  flexible_server_pvt_dns_vlink = module.vnet.vnet_name
  sku_name                      = var.sku_name
  mysql_version                 = var.mysql_version
  db_name                       = var.db_name
}
*/

#------------Frontdoor and CDN -------------

module "frontdoor_cdn" {
  source                          = "./modules/frontdoor"
  front_door_name                 = "${var.org}-fdcdn-${var.env}-${var.region}-${var.ins_count}"
  front_door_rg_name              = module.resource_group.rg_name
  front_door_sku_name             = var.front_door_sku_name[0]
  front_door_endpoint_name        = "${var.org}-ep-${var.env}-${var.region}-${var.ins_count}"
  front_door_origin_group_name    = "${var.org}-org-gp-${var.env}-${var.region}-${var.ins_count}"
  front_door_origin_name          = "${var.org}-org-${var.env}-${var.region}-${var.ins_count}"
  front_door_route_name           = "${var.org}-route-${var.env}-${var.region}-${var.ins_count}"
  storage_account_static          = module.storage_account["storage_account2"].primary_web_host
  depends_on                      = [module.storage_account] 

}


# ##---------------App-service------------------##

# module "app_service" {
#   source                  = "./modules/appservice"

#   #App service plan
#   asp_name                = "${var.org}-${local.client}-asp-${var.env}-${var.region}-${var.ins_count}"
#   asp_rg_location         = module.resource_group.rg_location
#   asp_rg_name             = module.resource_group.rg_name
#   asp_sku                 = var.asp_sku[1]

# #Web App
#   webapp_name             = "${var.org}-${local.client}-webapp-${var.env}-${var.region}-${var.ins_count}"
#   webapp_rg_location      = module.resource_group.rg_location
#   webapp_rg_name          = module.resource_group.rg_name
#   token                   = var.token
#   repo_url                = var.repo_url
#   repo_branch             = var.repo_branch
#   count                   = local.deploy_app_service == true ? 1 : 0
# }

##--------------- log analytics workspace---------------
module "law" {
  source                     = "./modules/law"
  count                      = 2
  logworkspace_name          = "${var.org}-law-${var.env}-${var.region}-${count.index}"
  logworkspace_location      = module.resource_group.rg_location
  logworkspace_rg_name       = module.resource_group.rg_name
}

/*
#----------------Automation Account ----------------

module "automation_account" {
  source          = "./modules/automation"
  auto_name          = "${var.org}-auto-${var.env}-${var.region}-${var.ins_count}"
  auto_rg_name       = module.resource_group.rg_name
  auto_location      = module.resource_group.rg_location
  auto_sku           = var.auto_sku
  auto_tags          = merge(local.default_tags, var.auto_tags)
  auto_scope         = module.resource_group.rg_id

#Runbook1
  runbook1_name     = "FrontendCode-backup-cleanup_runbook"
  runbook_rg        = module.resource_group.rg_name
  runbook_location  = module.resource_group.rg_location

#Runbook2
  runbook2_name     = "Trivy-old-scan-cleanup_runbook"

#Automation_Schedule
  schedule1_name    = "FrontendCode-backup-cleanup_schedule"
  schedule2_name    = "Trivy-old-scan-cleanup_schedule"
}
*/

##--------- Virtual network gateway ------------
module "virtual_network_gateway" {
  source                = "./modules/vnetgw"
  vnet_gw_pip_name      = "${var.org}-vpn-gw-pip-${var.env}-${var.region}-${var.ins_count}"
  vnet_gw_pip_location  = module.resource_group.rg_location
  vnet_gw_pip_rg        = module.resource_group.rg_name
  vnet_gw_name          = "${var.org}-vnetgw-${var.env}-${var.region}-${var.ins_count}"
  vnet_gw_location      = module.resource_group.rg_location
  vnet_gw_rg            = module.resource_group.rg_name
  vnet_gw_type          = var.vnet_gw_type[0]
  vnet_gw_vpn_type      = var.vnet_gw_vpn_type[0]
  vnet_gw_sku           = var.vnet_gw_sku[8]
  vnet_gw_subnet_id     = module.vnet.subnet_id.subnet5
  
}

/*
##---------Recovery service vault-------------
module "recovery_service_vault" {
  source                      = "./modules/rsvault"
  rsv_name                    = "${var.org}-rsvault-${var.env}-${var.region}-${var.ins_count}"
  rsv_location                = module.resource_group.rg_location
  rsv_rg                      = module.resource_group.rg_name
  rsv_sku                     = var.rsv_sku
  # backup_policy_vm_name       = "${var.org}-backup-policy-${var.env}-${var.region}-${var.ins_count}"
  # backup_policy_vm_rg         = module.resource_group.rg_name
  # backup_protected_vm_rg      = module.resource_group.rg_name
  # backup_protected_vm_rsvname = "${var.org}-rsvault-${var.env}-${var.region}-${var.ins_count}"
  # backup_protected_source_vm_id = module.vm.vm_ls_id
}
*/

##------------------------OpenAI------------------
module "openai" {
  source                     = "./modules/openai"
  opi_name                   = "${var.org}-${local.client}-openai-${var.env}-${var.region}-${var.ins_count}"
  opi_location               = var.opi_location
  opi_rg_name                = module.resource_group.rg_name
  opi_sku                    = var.opi_sku
  opi_tags                   = var.opi_tags
  deployments                = var.deployments
}
