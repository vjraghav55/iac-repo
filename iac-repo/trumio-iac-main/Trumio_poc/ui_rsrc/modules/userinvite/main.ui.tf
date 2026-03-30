resource "azuread_invitation" "invite" {
    #for_each           = var.user_invitations
    #user_display_name  = each.value.user_display_name
    #user_email_address = each.value.user_email_address
    #user_type          = each.value.user_type

#For single user invite
    user_display_name  = var.user_display_name
    user_email_address = var.user_email_address
    user_type          = var.user_type

    redirect_url       = "https://portal.azure.com"

  message {
    body               = "Hello there! You are invited to join my Azure tenant!"
  }
}


