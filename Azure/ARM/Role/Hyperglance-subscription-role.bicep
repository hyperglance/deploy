targetScope = 'subscription'

// A separate file is required for the management group variant because Bicep's targetScope
// is a compile-time directive and cannot be parameterised.

import { inventoryReadPermissions, buildRoleAssignmentDescription } from '_role-shared.bicep'

@description('Object ID of the Service Principal (Enterprise Application) associated with the App Registration. Required to create role assignments; omit to create the role definition only.')
param principalId string = ''

var roleName = 'Hyperglance_Inventory_Role'
var roleDefName = guid(roleName)

resource roleDef 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: roleDefName
  properties: {
    roleName: roleName
    description: 'Read-only inventory role for Hyperglance. Grants read access across all Azure resource types in this subscription. See https://support.hyperglance.com/knowledge/azure-iam-policy-requirements for more information.'
    type: 'CustomRole'
    permissions: inventoryReadPermissions
    assignableScopes: [
      subscription().id
    ]
  }
}

// Assign the role at subscription scope for inventory access.
resource inventoryAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = if (!empty(principalId)) {
  name: guid(subscription().id, principalId, roleDef.id)
  properties: {
    roleDefinitionId: roleDef.id
    principalId: principalId
    principalType: 'ServicePrincipal'
    description: buildRoleAssignmentDescription('subscription')
  }
}

output roleDefinitionId string = roleDef.id
output roleAssignmentId string = !empty(principalId) ? inventoryAssignment.id : ''
