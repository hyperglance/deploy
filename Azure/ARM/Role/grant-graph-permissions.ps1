#Requires -Modules Az.Accounts, Az.Resources
<#
.SYNOPSIS
    Grants Microsoft Graph application permissions required by the Hyperglance
    Microsoft Entra ID collector and performs admin consent.

.PARAMETER AppId
    The client ID of the app registration to grant permissions to.

.EXAMPLE
    .\grant-graph-permissions.ps1 -AppId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

.NOTES
    Prerequisites:
      - Az PowerShell module installed (Install-Module Az)
      - Logged in to Azure (Connect-AzAccount)
      - Sufficient privileges to grant admin consent (Global Administrator
        or Privileged Role Administrator)
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$AppId
)

$ErrorActionPreference = 'Stop'

$GraphApiId = "00000003-0000-0000-c000-000000000000"

$Permissions = @(
    "Application.Read.All"
    "Directory.Read.All"
    "AuditLog.Read.All"
    "UserAuthenticationMethod.Read.All"
    "User.Read.All"
)

Write-Host "Fetching Microsoft Graph service principal..."
$GraphSp = Get-AzADServicePrincipal -ApplicationId $GraphApiId

function Resolve-Permission {
    param([string]$Name)
    $role = $GraphSp.AppRole | Where-Object { $_.Value -eq $Name }
    if (-not $role) {
        Write-Error "Could not resolve permission '$Name'"
        exit 1
    }
    return $role.Id
}

Write-Host "Adding permissions to app registration $AppId..."
foreach ($Perm in $Permissions) {
    $Id = Resolve-Permission -Name $Perm
    Write-Host "  Adding $Perm ($Id)"
    az ad app permission add `
        --id $AppId `
        --api $GraphApiId `
        --api-permissions "$Id=Role"
}

Write-Host "Granting admin consent..."
az ad app permission admin-consent --id $AppId

Write-Host "Done. The following permissions have been granted:"
foreach ($Perm in $Permissions) {
    Write-Host "  - $Perm"
}
