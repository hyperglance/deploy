// Internal module — not intended to be deployed standalone.
// Deployed at resource group scope to create a role assignment on a specific blob container.
targetScope = 'resourceGroup'

@description('Name of the storage account that holds the billing exports.')
param storageAccountName string

@description('Name of the container inside the storage account that holds the billing exports.')
param containerName string

@description('Object ID of the principal (App Registration) to assign the role to.')
param principalId string

@description('Resource ID of the role definition to assign.')
param roleDefinitionId string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' existing = {
  name: storageAccountName
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' existing = {
  parent: storageAccount
  name: 'default'
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' existing = {
  parent: blobService
  name: containerName
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(container.id, principalId, roleDefinitionId)
  scope: container
  properties: {
    roleDefinitionId: roleDefinitionId
    principalId: principalId
    principalType: 'ServicePrincipal'
    description: 'Hyperglance: read access to billing export data in this container'
  }
}

output roleAssignmentId string = roleAssignment.id
