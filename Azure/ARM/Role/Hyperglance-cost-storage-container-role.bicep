targetScope = 'subscription'

@description('Object ID of the App Registration (Service Principal) to grant access to the billing export container.')
param principalId string

@description('Subscription ID containing the storage account. Defaults to the subscription being deployed into.')
param storageAccountSubscriptionId string = subscription().subscriptionId

@description('Resource group name containing the storage account.')
param storageAccountResourceGroup string

@description('Name of the storage account that holds the billing exports.')
param storageAccountName string

@description('Name of the container inside the storage account that holds the billing exports.')
param containerName string

var roleName = 'Hyperglance_Cost_Storage_Container_Role'
var roleDefName = guid(roleName)

resource roleDef 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: roleDefName
  properties: {
    roleName: roleName
    description: 'Minimal role for Hyperglance to read Azure billing exports from blob storage. Grants read access to blob data only — no storage account key access. See https://support.hyperglance.com/knowledge/how-to-enable-cost-collection-in-azure for more information.'
    type: 'CustomRole'
    permissions: [
      {
        actions: []
        notActions: []
        dataActions: [
          'Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read'
        ]
        notDataActions: []
      }
    ]
    assignableScopes: [
      subscription().id
    ]
  }
}

// Assign the role to the App Registration, scoped to the specific container only.
module containerAssignment '_container-role-assignment.bicep' = {
  name: 'Hyperglance-container-role-assignment'
  scope: resourceGroup(storageAccountSubscriptionId, storageAccountResourceGroup)
  params: {
    storageAccountName: storageAccountName
    containerName: containerName
    principalId: principalId
    roleDefinitionId: roleDef.id
  }
}

output roleDefinitionId string = roleDef.id
output roleAssignmentId string = containerAssignment.outputs.roleAssignmentId
