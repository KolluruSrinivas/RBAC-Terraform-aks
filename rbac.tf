# resource "azurerm_role_definition" "aks_cluster_admin" {
#   name        = "AKSClusterAdmin"
#   scope       = "/subscriptions/8258e319-97da-4600-a76c-49edbf93df29"
#   permissions {
#     actions     = [
#       "Microsoft.ContainerService/managedClusters/*",  # Full control over AKS clusters
#     ]
#     not_actions = []
#   }
#   assignable_scopes = ["/subscriptions/8258e319-97da-4600-a76c-49edbf93df29"]
# }

# #   resource "azurerm_role_definition" "aks_cluster_user" {
# #   name        = "AKSClusterUser"
# #   scope       = "/subscriptions/8258e319-97da-4600-a76c-49edbf93df29"
# #   permissions {
# #     actions     = [
# #       "Microsoft.ContainerService/managedClusters/read",
# #       "Microsoft.ContainerService/managedClusters/write",
# #       "Microsoft.ContainerService/managedClusters/delete",
# #       "Microsoft.ContainerService/managedClusters/listClusterUserCredential/action"
# #     ]
# #     not_actions = []
# #  }
# #  assignable_scopes = ["/subscriptions/8258e319-97da-4600-a76c-49edbf93df29"]
# #  }

#   resource "azurerm_role_assignment" "aks_role_assignment" {
#   scope                = "myAKSCluster"
#   role_definition_name = "AKSClusterAdmin"
#    principal_id         = "13268c35-6701-4090-be71-f8bc04bafec6"  # Replace with object ID of the Azure AD user
#  }

 



