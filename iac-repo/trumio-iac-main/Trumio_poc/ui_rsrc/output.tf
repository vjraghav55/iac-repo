output "user_invitations" {
    value = local.user_invitations
}

output "user_id" {
  description = "Output of user IDs generated"
  value = { for key, invitation in azuread_invitation.user_invite : key => invitation.user_id }
}

output "client_id" {
  description = "Output of client ID generated"
  value = azuread_invitation.client_invite.user_id
}


