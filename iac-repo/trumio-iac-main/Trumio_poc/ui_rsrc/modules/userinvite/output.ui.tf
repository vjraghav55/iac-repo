#output "user_id" {
 # description = "Map of user IDs generated"
  #value = { for key, invitation in azuread_invitation.invite : key => invitation.user_id }
#}

output "user_id" {
  description = "Map of user ID generated"
  value = azuread_invitation.invite.user_id 
}





