targetScope = 'managementGroup'

// A separate file is required because Bicep's targetScope is a compile-time directive
// and cannot be parameterised. The subscription variant is deployed with
// `az deployment sub create`; this management group variant uses
// `az deployment mg create --management-group-id <id>`.

import { inventoryReadPermissions, buildRoleAssignmentDescription } from '_role-shared.bicep'

@description('Object ID of the Service Principal (Enterprise Application) associated with the App Registration. Required to create role assignments; omit to create the role definition only.')
param principalId string = ''

var roleName = 'Hyperglance_Inventory_Role_MG'
var roleDefName = guid(roleName)

resource roleDef 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: roleDefName
  properties: {
    roleName: roleName
    description: 'Read-only inventory role for Hyperglance at Management Group scope. Grants read access across all Azure resource types in all subscriptions under this Management Group or Tenant. See https://support.hyperglance.com/knowledge/azure-iam-policy-requirements for more information.'
    type: 'CustomRole'
    permissions: inventoryReadPermissions
    assignableScopes: [
      managementGroup().id
    ]
  }
}

// Assign the role at management group scope for inventory access.
resource inventoryAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = if (!empty(principalId)) {
  name: guid(managementGroup().id, principalId, roleDef.id)
  properties: {
    roleDefinitionId: roleDef.id
    principalId: principalId
    principalType: 'ServicePrincipal'
    description: buildRoleAssignmentDescription('management group')
  }
}

output roleDefinitionId string = roleDef.id
output roleAssignmentId string = !empty(principalId) ? inventoryAssignment.id : ''
