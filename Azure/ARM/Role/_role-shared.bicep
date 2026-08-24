// Shared data/shape for the subscription- and management-group-scoped role
// definitions. Only literal values and pure functions live here — the
// resource declarations themselves must stay in each scope-specific file
// because Microsoft.Authorization/roleDefinitions and roleAssignments are
// deployed at a fixed targetScope that Bicep cannot parameterise or nest.

@export()
var inventoryReadPermissions = [
  {
    actions: [
      '*/read'
    ]
    notActions: []
    dataActions: []
    notDataActions: []
  }
]

@export()
func buildRoleAssignmentDescription(scopeLabel string) string =>
  'Hyperglance: read-only inventory access to this ${scopeLabel}'
