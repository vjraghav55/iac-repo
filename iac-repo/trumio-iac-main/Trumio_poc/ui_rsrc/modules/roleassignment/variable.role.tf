variable "scope" {
  description = "The scope at which the role assignment should be created"
}

variable "role_definition" {
  description = "The name of the role definition to assign"
}

#variable "principal_ids" {
 # description = "Map of principal IDs to assign the role."
#}

variable "principal_id" {
  description = "Map of principal IDs to assign the role."
}
