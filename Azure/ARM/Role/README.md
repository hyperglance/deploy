<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../../files/hyperglance_logo_dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="../../../files/hyperglance_logo_light.svg">
  <img alt="Hyperglance logo" src="../../../files/hyperglance_logo_dark.svg">
</picture>

# Hyperglance Role Templates [ARM]

Choose the template that matches what you are connecting in Hyperglance:

| Scenario | Template | RBAC permissions granted |
|---|---|---|
| **Single subscription** | [`Hyperglance-subscription-role.json`](#single-subscription) | `*/read` |
| **Management Group / Tenant** | [`Hyperglance-mg-role.json`](#management-group--tenant) | `*/read` across the entire MG/tenant |
| **Billing export** — cost source only | [`Hyperglance-cost-storage-container-role.json`](#billing-export--cost-source-only) | blob data read only |

> **Note:** Each template creates a custom role *definition* **and** the role *assignment* when you supply `principalId`. If you omit `principalId`, only the definition is created and you can assign it manually afterwards.
>
> `principalId` is the **Service Principal Object ID** — found under **Entra ID → Enterprise Applications → [your app] → Properties → Object ID**, or via CLI:
> ```bash
> az ad sp show --id <application-client-id> --query id -o tsv
> ```

---

## Prerequisites — App Registration

Hyperglance authenticates to Azure using an App Registration with a client secret. If you haven't created one yet:

```bash
# Create the App Registration and Service Principal
APP_ID=$(az ad app create --display-name Hyperglance --query appId -o tsv)
SP_OBJECT_ID=$(az ad sp create --id $APP_ID --query id -o tsv)

# Create a client secret
az ad app credential reset --id $APP_ID --append --display-name "Hyperglance"
```

The last command outputs the **client secret** (`password`), **Application (client) ID** (`appId`), and **tenant ID** — save these immediately, as the secret is only shown once. You will need all three when configuring Hyperglance.

`SP_OBJECT_ID` is the **Service Principal Object ID** used as `principalId` in the deployment steps below.

---

## [Optional] Azure Entra access monitoring

Hyperglance has rulesets that help improve your entra security such as monitoring for old passwords.  To enable this you must grant the app-registration permissions against the the Microsoft Graph API.  Since this cannot be done with an ARM template we have provided a script `grant-graph-permissions.sh`.

The login you use must have **Global Administrator** or **Privileged Role Administrator** role in order to grant admin consent.

Run **one** of the following:

**PowerShell** (requires Azure CLI and the `Az` PowerShell module):
```powershell
Connect-AzAccount
.\grant-graph-permissions.ps1 -AppId <app-registration-client-id>
```

**Bash** (requires Azure CLI and `jq`):
```bash
az login
./grant-graph-permissions.sh --app-id <app-registration-client-id>
```

This grants the following Microsoft Graph application permissions and performs tenant-wide admin consent:

| Permission | Purpose |
|---|---|
| `Application.Read.All` | List app registrations |
| `Directory.Read.All` | Resolve users, groups and service principals |
| `AuditLog.Read.All` | Read sign-in logs (requires Azure AD Premium P1 or P2) |
| `UserAuthenticationMethod.Read.All` | Check MFA registration status |
| `User.Read.All` | Read password change dates |

> **Note:** Sign-in log data (`AuditLog.Read.All`) is only available on Azure AD Premium P1 or P2 tenants. Hyperglance will work without it — sign-in fields will simply be blank.

---

## Single subscription

**Template:** `Hyperglance-subscription-role.bicep` / `Hyperglance-subscription-role.json`

Creates the `Hyperglance_Inventory_Role` custom role at subscription scope.

> **Note:** Reservations and Savings Plans are tenant-scoped billing resources, not subscription resources — a subscription-scoped role assignment (even with `*/read`) does **not** grant access to them, regardless of which actions the role includes. If you want Hyperglance to discover existing Reserved Instance / Savings Plan commitments and fetch purchase recommendations, assign the [Management Group / Tenant](#management-group--tenant) role at your **root** management group instead.

### Deploy via Azure Portal

[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FRole%2FHyperglance-subscription-role.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FRole%2FHyperglance-subscription-role-ui.json)
[![Deploy To Azure US Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FRole%2FHyperglance-subscription-role.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FRole%2FHyperglance-subscription-role-ui.json)

The portal will show a guided form. Leave **Service Principal Object ID** blank to create only the role definition, or fill it in to also create the assignment.

### Deploy via Azure CLI

Role definition only:

```bash
az deployment sub create \
  --location <location> \
  --template-file Hyperglance-subscription-role.json
```

Role definition + assignment:

```bash
az deployment sub create \
  --location <location> \
  --template-file Hyperglance-subscription-role.json \
  --parameters principalId=<service-principal-object-id>
```

This creates:
1. The `Hyperglance_Inventory_Role` definition.
2. A role assignment at **subscription scope** — for inventory.

---

## Management Group / Tenant

**Template:** `Hyperglance-mg-role.bicep` / `Hyperglance-mg-role.json`

Creates the `Hyperglance_Inventory_Role_MG` custom role at management group scope, covering all subscriptions in the group.

> **Note:** Reservation and Savings Plan discovery (existing commitments and purchase recommendations) requires this role to be assigned at the **root** management group — a role assigned at a lower management group only grants inventory access to the subscriptions beneath it, not to these tenant-scoped billing resources.

### Deploy via Azure Portal

[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FRole%2FHyperglance-mg-role.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FRole%2FHyperglance-mg-role-ui.json)
[![Deploy To Azure US Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FRole%2FHyperglance-mg-role.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FRole%2FHyperglance-mg-role-ui.json)

The portal will show a guided form. Leave **Service Principal Object ID** blank to create only the role definition, or fill it in to also create the assignment.

### Deploy via Azure CLI

Role definition only:

```bash
az deployment mg create \
  --management-group-id <management-group-id> \
  --location <location> \
  --template-file Hyperglance-mg-role.json
```

Role definition + assignment:

```bash
az deployment mg create \
  --management-group-id <management-group-id> \
  --location <location> \
  --template-file Hyperglance-mg-role.json \
  --parameters principalId=<service-principal-object-id>
```

This creates:
1. The `Hyperglance_Inventory_Role_MG` definition.
2. A role assignment at **management group scope** — for inventory.

For a **Tenant** connection, use your root management group ID as `--management-group-id`.

---

## Billing export — cost source only

**Template:** `Hyperglance-cost-storage-container-role.bicep` / `Hyperglance-cost-storage-container-role.json`

Creates the `Hyperglance_Cost_Storage_Container_Role` custom role and assigns it to your Service Principal, scoped to the specific billing export container — no storage account key access, no management plane access, no access to other containers.

Use it when connecting an Azure billing export as a cost source in Hyperglance without full resource inventory.

### Deploy via Azure Portal

[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FRole%2FHyperglance-cost-storage-container-role.json)
[![Deploy To Azure US Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FRole%2FHyperglance-cost-storage-container-role.json)

The portal will show a parameter form — fill in your Service Principal Object ID and storage container details.

### Deploy via Azure CLI

```bash
az deployment sub create \
  --location <location> \
  --template-file Hyperglance-cost-storage-container-role.json \
  --parameters \
      principalId=<service-principal-object-id> \
      storageAccountResourceGroup=<rg-name> \
      storageAccountName=<storage-account-name> \
      containerName=<container-name>
```

If the storage account is in a different subscription, also pass `storageAccountSubscriptionId=<sub-id>`.

---

## Next steps

Once deployed, find the outputs (role definition ID and, if `principalId` was supplied, the role assignment ID) in the Azure Portal under **Deployments → Outputs**, or via:

```bash
# For subscription-scoped deployments (Hyperglance-subscription-role.json, Hyperglance-cost-storage-container-role.json)
az deployment sub show --name <deployment-name> --query properties.outputs

# For management-group-scoped deployments (Hyperglance-mg-role.json)
az deployment mg show --management-group-id <management-group-id> --name <deployment-name> --query properties.outputs
```

- **Inventory setup:** configure the App Registration in Hyperglance using the [Azure IAM policy requirements guide](https://support.hyperglance.com/knowledge/azure-iam-policy-requirements).
- **Cost collection:** [enable cost collection in Azure](https://support.hyperglance.com/knowledge/how-to-enable-cost-collection-in-azure) to connect a billing export as a cost source.
