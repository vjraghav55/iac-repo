#------------------data source----------------

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.tf_state
}


#----------------local variable---------------

locals {
  client_name             = var.client_name
  client_email_address    = var.client_email_address
  client_type             = var.client_type
  rsc_grp_name            = var.rsc_grp_name
  location                = var.location
  storage_account_deploy  = var.storage_account_deploy
  openai_deploy           = var.openai_deploy
  openai_model_name       = var.openai_model_name
  openai_model_version    = var.openai_model_version
  textanalytics_deploy    = var.textanalytics_deploy
  faceapi_deploy          = var.faceapi_deploy
  computervision_deploy   = var.computervision_deploy
  app_service_deploy      = var.app_service_deploy

  user_data = can(file("${path.module}/users.json")) ? jsondecode(file("${path.module}/users.json")) : []

  user_invitations = [
        for user in local.user_data : {
            user_display_name = user.user_display_name
            user_email_address = user.user_email_address
            user_type = user.user_type
        }
    ]
  default_tags = {
    env = "Prod",
    biz = "Operations"
  }
}


#-----------Resource-group module-------------

module "resource_group" {
  source         = "./modules/rg"
  rg_name        = "${local.rsc_grp_name}-rg"
  rg_location    = local.location
  rg_tags        = merge(local.default_tags, var.rg_tags)
}


#-----------Virtual Network module------------

# module "vnet" {
#   source                     = "./modules/vnet"
#   vnet_name                  = "${var.org}-${local.client}-vnet-${var.env}-${var.region}-${var.ins_count}"
#   vnet_location              = module.resource_group.rg_location
#   vnet_rg_name               = module.resource_group.rg_name
#   vnet_address_prefix        = var.vnet_address_prefix
#   vnet_tags                  = merge(local.default_tags, var.vnet_tags)
#   subnets                    = var.subnets
# }


#---------Storage account module------------

resource "random_id" "storage_account" {
  byte_length = 2
}

module "storage_account" {
  source                      = "./modules/sa"
  sa_name                     = "${var.org}storage${lower(random_id.storage_account.hex)}"
  sa_rg_name                  = module.resource_group.rg_name
  sa_location                 = module.resource_group.rg_location
  sa_account_tier             = var.sa_account_tier[0]
  sa_account_kind             = var.sa_account_kind[4]
  sa_access_tier              = var.sa_access_tier[0]
  sa_account_replication_type = var.sa_account_replication_type[0]
  sa_tags                     = merge(local.default_tags, var.sa_tags)
  containers                  = var.containers
  count                       = local.storage_account_deploy == true ? 1 : 0
}

##------------------OpenAI----------------

module "openai" {
  source                     = "./modules/openai"
  opi_name                   = "${var.org}-openai"
  opi_location               = module.resource_group.rg_location
  opi_rg_name                = module.resource_group.rg_name
  opi_sku                    = var.opi_sku
  opi_tags                   = var.opi_tags
  opi_deploy_name            = var.opi_deploy_name
  model_name                 = var.openai_model_name
  model_version              = var.openai_model_version 
  #deployments                = var.deployments
  count                      = local.openai_deploy == true ? 1 : 0
}

##------------------Text Analytics----------------

module "textanalytics" {
  source                    = "./modules/analytics"
  ta_name                   = "${var.org}-txtanalytics"
  ta_location               = module.resource_group.rg_location
  ta_rg_name                = module.resource_group.rg_name
  ta_sku                    = var.ta_sku
  ta_tags                   = var.ta_tags
  # ta_deploy_name            = var.ta_deploy_name
  # ta_model_name             = var.analytics_model_name
  # ta_model_version          = var.analytics_model_version 
  #deployments                = var.deployments
  count                     = local.textanalytics_deploy == true ? 1 : 0
}

##------------------Face API----------------

module "faceapi" {
  source                     = "./modules/face"
  fa_name                   = "${var.org}-faceapi"
  fa_location               = module.resource_group.rg_location
  fa_rg_name                = module.resource_group.rg_name
  fa_sku                    = var.faceapi_sku
  fa_tags                   = var.facepi_tags
  # fa_deploy_name            = var.faceapi_deploy_name
  # face_model_name             = var.face_model_name
  # face_model_version          = var.face_model_version 
  #deployments                = var.deployments
  count                      = local.faceapi_deploy == true ? 1 : 0
}

##------------------Custom vision----------------

module "computervision" {
  source                    = "./modules/vision"
  cv_name                   = "${var.org}-vision"
  cv_location               = module.resource_group.rg_location
  cv_rg_name                = module.resource_group.rg_name
  cv_sku                    = var.vision_sku
  cv_tags                   = var.vision_tags
  # vision_deploy_name        = var.vision_deploy_name
  # vision_model_name         = var.vision_model_name
  # vision_model_version       = var.vision_model_version 
  #deployments                = var.deployments
  count                     = local.computervision_deploy == true ? 1 : 0
}

##---------------App-service------------------##

module "app_service" {
  source                  = "./modules/appservice"

  # App service plan
  asp_name                = "${var.org}-asp"
  asp_rg_location         = module.resource_group.rg_location
  asp_rg_name             = module.resource_group.rg_name
  asp_sku                 = var.asp_sku[1]

  # Web App
  webapp_name             = "${var.org}-webapp"
  webapp_rg_location      = module.resource_group.rg_location
  webapp_rg_name          = module.resource_group.rg_name
  # token                   = var.token
  # repo_url                = var.repo_url
  # repo_branch             = var.repo_branch
  count                   = local.app_service_deploy == true ? 1 : 0
}

##---------------User invitation----------

resource "azuread_invitation" "user_invite" {
    for_each = { for key, user in local.user_invitations : key => user }

    user_display_name  = each.value.user_display_name
    user_email_address = each.value.user_email_address
    user_type          = each.value.user_type
    redirect_url       = "https://portal.azure.com"

    message {
        body = "Hello there! You are invited to join Trumio-Azure tenant!"
    }
    depends_on        = [ module.resource_group, module.storage_account, module.app_service, module.computervision, module.faceapi, module.textanalytics, module.openai ]
}

resource "azuread_invitation" "client_invite" {
    user_display_name  = local.client_name
    user_email_address = local.client_email_address
    user_type          = local.client_type
    redirect_url       = "https://portal.azure.com"

    message {
        body = "Hello there! You are invited to join Trumio-Azure tenant!"
    }
    depends_on        = [ module.resource_group, module.storage_account, module.app_service, module.computervision, module.faceapi, module.textanalytics, module.openai ]
}



#--------------AD group-----------------

resource "azuread_group" "trumio_group" {
  display_name     = "${local.client_name}-group"
  description      = "Group for invited users"
  security_enabled = true
  depends_on       = [ module.resource_group, module.storage_account, module.app_service, module.computervision, module.faceapi, module.textanalytics, module.openai, azuread_invitation.user_invite, azuread_invitation.client_invite ]
}

resource "azuread_group_member" "trumio_group_members" {
  for_each         = { for idx, invitation in azuread_invitation.user_invite : idx => invitation.user_id }
  group_object_id  = azuread_group.trumio_group.id
  member_object_id = each.value
  depends_on       = [ module.resource_group, module.storage_account, module.app_service, module.computervision, module.faceapi, module.textanalytics, module.openai, azuread_invitation.user_invite, azuread_invitation.client_invite ]

}

##----------------Role assignment----------

# For individual user permission
resource "azurerm_role_assignment" "client" {
  scope                = module.resource_group.rg_id
  role_definition_name = var.owner_role
  principal_id         = azuread_invitation.client_invite.user_id
  depends_on           = [ module.resource_group, module.storage_account, module.app_service, module.computervision, module.faceapi, module.textanalytics, module.openai, azuread_invitation.user_invite, azuread_invitation.client_invite, azuread_group.trumio_group, azuread_group_member.trumio_group_members ]

}

## For group role assignment

resource "azurerm_role_assignment" "trumio" {
  for_each             = toset(var.contrib_role) 
  scope                = module.resource_group.rg_id
  role_definition_name = each.value
  principal_id         = azuread_group.trumio_group.id
  depends_on           = [ module.resource_group, module.storage_account, module.app_service, module.computervision, module.faceapi, module.textanalytics, module.openai, azuread_invitation.user_invite, azuread_invitation.client_invite, azuread_group.trumio_group, azuread_group_member.trumio_group_members ]
}

