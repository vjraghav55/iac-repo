
output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

# output "aks_fqdn" {
#   value = azurerm_kubernetes_cluster.aks.fqdn
# }

output "aks_private_fqdn" {
  value = azurerm_kubernetes_cluster.aks.private_fqdn
}

# output "aks_usrnp_id" {
#   value = azurerm_kubernetes_cluster_node_pool.aks_usrnp.id
# }