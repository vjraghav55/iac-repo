variable "aks_name" {
  description = "AKS cluster name"
  type = string
}

variable "aks_location" {
  description = "AKS cluster location"
  type = string
}

variable "aks_rg_name" {
  description = "AKS cluster rg name"
  type = string
}

variable "aks_dns_prefix" {
  description = "AKS cluster dns prefix"
  type = string
}

variable "aks_kubernetes_version" {
  description = "AKS cluster kubernetes version"
}

variable "tenant_id" {
  description = "AKS cluster tenant id"
}

variable "aks_sku" {
    description = "AKS cluster sku"
}   


# System node pool
variable "aks_sysnp_name" {
  description = "AKS cluster system node pool name"
  type = string
}

variable "aks_sysnp_node_count" {
  description = "AKS cluster system node pool count"
}

variable "aks_sysnp_min_count" {
  description = "AKS cluster system node pool min count"
}

variable "aks_sysnp_max_count" {
  description = "AKS cluster system np max count"
}

variable "aks_sysnp_max_pods" {
  description = "AKS cluster system np min count"
}

variable "aks_sysnp_vm_size" {
  description = "AKS cluster system np vm size"
}

variable "aks_sysnp_os_disk_size_gb" {
  description = "AKS cluster system np os disk size gb"
}

variable "aks_sysnp_os_disk_type" {
  description = "AKS cluster system np os disk type"
}

variable "aks_sysnp_os_sku" {
  description = "AKS cluster system np os sku"
}

variable "aks_sysnp_vnet_subnet_id" {
  description = "AKS cluster system node pool vnet subnet id"
}

variable "aks_sysnp_node_labels" {
  description = "AKS cluster system node pool node labels"
    type = map(any)
}

variable "aks_sysnp_tags" {
  description = "AKS cluster system node pool tags"
    type = map(any)
}

# User node pool
variable "aks_usrnp_names" {
  description = "AKS cluster user node pool name"
}

variable "aks_usrnp_node_count" {
  description = "AKS cluster user node pool count"
}

variable "aks_usrnp_min_count" {
  description = "AKS cluster user node pool min count"
}

variable "aks_usrnp_max_count" {
  description = "AKS cluster user np max count"
}

variable "aks_usrnp_max_pods" {
  description = "AKS cluster user np min count"
}

variable "aks_usrnp_vm_sizes" {
  description = "AKS cluster user np vm size"
}

variable "aks_usrnp_os_disk_size_gb" {
  description = "AKS cluster user np os disk size gb"
}

variable "aks_usrnp_os_disk_type" {
  description = "AKS cluster user np os disk type"
}

variable "aks_usrnp_os_sku" {
  description = "AKS cluster user np os sku"
}

variable "aks_usrnp_vnet_subnet_id" {
  description = "AKS cluster user node pool vnet subnet id"
}

variable "aks_usrnp_node_labels" {
  description = "AKS cluster user node pool node labels"
  type = map(any)
}

variable "aks_usrnp_tags" {
  description = "AKS cluster user node pool tags"
    type = map(any)
}

