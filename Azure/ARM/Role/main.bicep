targetScope = 'subscription'

@description('Array of actions for the roleDefinition')
param actions array = [
  '*/read'
  'Microsoft.Storage/storageAccounts/listKeys/action'
]

@description('Array of notActions for the roleDefinition')
param notActions array = [
  'Microsoft.Storage/*/delete'
  'Microsoft.Storage/*/write'
]

@description('Array of dataActions for the roleDefinition')
param dataActions array = []

@description('Array of dataActions for the roleDefinition')
param notDataActions array = []

@description('Friendly name of the role definition')
param roleName string = 'Hyperglance_Read_Only_role'

@description('Detailed description of the role definition')
param roleDescription string = 'Read only role for Hyperglance. See https://support.hyperglance.com/knowledge/how-to-enable-cost-collection-in-azure for more information'

var roleDefName = guid(roleName)

resource roleDef 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: roleDefName
  properties: {
    roleName: roleName
    description: roleDescription
    type: 'customRole'
    permissions: [
      {
        actions: actions
        notActions: notActions
        dataActions: dataActions
        notDataActions: notDataActions
      }
    ]
    assignableScopes: [
      subscription().id
    ]
  }
}
