#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 --app-id <app-registration-client-id>"
  echo ""
  echo "Grants the Microsoft Graph application permissions required by the"
  echo "Hyperglance Microsoft Entra ID collector, and performs admin consent."
  echo ""
  echo "Prerequisites:"
  echo "  - Azure CLI installed and logged in (az login)"
  echo "  - Sufficient privileges to grant admin consent (Global Administrator"
  echo "    or Privileged Role Administrator)"
  exit 1
}

APP_ID=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --app-id) APP_ID="$2"; shift 2 ;;
    *) usage ;;
  esac
done

[[ -z "$APP_ID" ]] && usage

GRAPH_API_ID="00000003-0000-0000-c000-000000000000"

PERMISSIONS=(
  "Application.Read.All"
  "Directory.Read.All"
  "AuditLog.Read.All"
  "UserAuthenticationMethod.Read.All"
  "User.Read.All"
)

echo "Fetching Microsoft Graph service principal..."
GRAPH_SP=$(az ad sp show --id "$GRAPH_API_ID")

resolve_permission() {
  local name="$1"
  local id
  id=$(echo "$GRAPH_SP" | jq -r --arg name "$name" '.appRoles[] | select(.value == $name) | .id')
  if [[ -z "$id" || "$id" == "null" ]]; then
    echo "ERROR: Could not resolve permission '$name'" >&2
    exit 1
  fi
  echo "$id"
}

echo "Adding permissions to app registration $APP_ID..."
for PERM in "${PERMISSIONS[@]}"; do
  ID=$(resolve_permission "$PERM")
  echo "  Adding $PERM ($ID)"
  az ad app permission add \
    --id "$APP_ID" \
    --api "$GRAPH_API_ID" \
    --api-permissions "$ID=Role"
done

echo "Granting admin consent..."
az ad app permission admin-consent --id "$APP_ID"

echo "Done. The following permissions have been granted:"
for PERM in "${PERMISSIONS[@]}"; do
  echo "  - $PERM"
done
