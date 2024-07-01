variable "subscription_id" {
  description = "Azure subscription ID"
  default = "8258e319-97da-4600-a76c-49edbf93df29"
}

variable "location" {
  description = "Azure region"
  default     = "East US"  # Change to your desired region
}

variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "RG-Terraform"
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  default     = "TerraformVirtualNetwork"
}

variable "subnet_name" {
  description = "Name of the subnet"
  default     = "myAKSSubnet"
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  default     = "myAKSCluster"
}

variable "aks_kubernetes_version" {
  description = "Kubernetes version for AKS cluster"
  default     = "1.28.9"  # Change to your desired Kubernetes version
}
