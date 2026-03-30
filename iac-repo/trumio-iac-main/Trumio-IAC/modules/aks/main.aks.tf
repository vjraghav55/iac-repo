resource "azurerm_kubernetes_cluster" "aks" {
  name                      = var.aks_name
  location                  = var.aks_location
  resource_group_name       = var.aks_rg_name
  dns_prefix                = var.aks_dns_prefix
  kubernetes_version        = var.aks_kubernetes_version
  private_cluster_enabled   = true
  sku_tier                  = var.aks_sku

  
  #azure_active_directory_role_based_access_control {
   # managed            = true
    #tenant_id          = var.tenant_id
    #azure_rbac_enabled = true
  #}

  default_node_pool {
    name                    = var.aks_sysnp_name
    node_count              = var.aks_sysnp_node_count
    vm_size                 = var.aks_sysnp_vm_size
    min_count               = var.aks_sysnp_min_count
    max_count               = var.aks_sysnp_max_count
    max_pods                = var.aks_sysnp_max_pods
    os_disk_size_gb         = var.aks_sysnp_os_disk_size_gb
    os_disk_type            = var.aks_sysnp_os_disk_type
    os_sku                  = var.aks_sysnp_os_sku
    enable_auto_scaling     = true
    enable_host_encryption  = true
    vnet_subnet_id          = var.aks_sysnp_vnet_subnet_id
    node_labels             = var.aks_sysnp_node_labels
    orchestrator_version    = var.aks_kubernetes_version
    tags                    = var.aks_sysnp_tags
  }

  network_profile {
    network_plugin  = "azure"
    network_policy  = "azure"
    outbound_type   = "loadBalancer"
    service_cidr    = "192.168.0.0/16"
    dns_service_ip  = "192.168.0.10"
  }
  
  lifecycle {
    ignore_changes = [ 
        default_node_pool[0].node_count,
        default_node_pool[0].orchestrator_version,
        kubernetes_version
     ]
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "aks_usrnp" {
  count = length(var.aks_usrnp_names)

  kubernetes_cluster_id   = azurerm_kubernetes_cluster.aks.id
  name                    = var.aks_usrnp_names[count.index]
  vm_size                 = var.aks_usrnp_vm_sizes[count.index]
  node_count              = var.aks_usrnp_node_count
  min_count               = var.aks_usrnp_min_count
  max_count               = var.aks_usrnp_max_count
  max_pods                = var.aks_usrnp_max_pods
  os_disk_size_gb         = var.aks_usrnp_os_disk_size_gb
  os_disk_type            = var.aks_usrnp_os_disk_type
  os_sku                  = var.aks_usrnp_os_sku
  enable_auto_scaling     = true
  enable_host_encryption  = true
  mode                    = "User"
  os_type                 = "Linux"
  priority                = "Regular"
  vnet_subnet_id          = var.aks_usrnp_vnet_subnet_id
  node_labels             = var.aks_usrnp_node_labels
  orchestrator_version    = var.aks_kubernetes_version
  tags                    = var.aks_sysnp_tags
}

