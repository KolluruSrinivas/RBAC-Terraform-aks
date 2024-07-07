terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # Ensure you use a version that supports role_based_access_control
    }
  }
  required_version = ">= 1.1.0"
}
provider "azurerm" {
  features {}
}

data "azurerm_subscription" "primary" {}

data "azuread_user" "Manu" {
  user_principal_name = "Manu@Sandeepmk1996outlook.onmicrosoft.com"
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = "myAKSCluster"
  resource_group_name = "resourcegroupname"
}

data "azuread_group" "aks" {
  display_name = "aks-admins"
}

resource "azurerm_role_assignment" "user_role_assignment" {
  scope                = data.azurerm_kubernetes_cluster.example.id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_user.example.id
}

resource "azurerm_role_assignment" "group_role_assignment" {
  scope                = data.azurerm_kubernetes_cluster.example.id
  role_definition_name = "Reader"
  principal_id         = data.azuread_group.example.id
}

provider "azurerm" {
  features {}

  subscription_id = "c9a21e48-7c43-4ec1-9b95-eab32a531266"
  client_id       = "883900c0-0a7c-42ee-8ad8-7b212875ef54"
  client_secret   = "uQU8Q~kqmzbxY4IjM4GX5lw7GW_aKpR6EZ3WGb.7"
  tenant_id       = "74271a2c-26b2-466d-b57b-7d18c07d0b63"
}
resource "azurerm_subscription" "primary" {
    subscription_name="Azure subscription 1"
}
resource "azurerm_role_definition" "aks_custom_role"{
  scope       = data.azurerm_subscription.primary.id
  name ="Azure Kubernetes Service RBAC Reader"
}

resource "azurerm_resource_group" "aks" {
  name     = "resourcegroupname"
  location = "West Europe"
}
resource "azurerm_role_assignment" "aks_role_assignment" {
  scope                = data.azurerm_kubernetes_cluster.aks.id
  principal_id         = "3c0fd7cf-5562-4f30-b48f-52bd72f67e10"
}
data "azurerm_kubernetes_cluster" "aks" {
  name                = myAKSCluster
  resource_group_name = resourcegroupname
}
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "myAKSCluster"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "aks"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }  
  
}


provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks.kube_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
}

resource "azurerm_resource_group" "aks" {
  name     = "resourcegroupname"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "myAKSCluster"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "aks-cluster"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "kubernetes_manifest" "deployment" {
  manifest = yamldecode(file("${path.module}/deployment.yaml"))
}

resource "kubernetes_manifest" "service" {
  manifest = yamldecode(file("${path.module}/service.yaml"))
}

resource "kubernetes_manifest" "ingress" {
  manifest = yamldecode(file("${path.module}/ingress.yaml"))
}