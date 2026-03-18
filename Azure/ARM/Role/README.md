<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../../files/hyperglance_logo_dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="../../../files/hyperglance_logo_light.svg">
  <img alt="Hyperglance logo" src="../../../files/hyperglance_logo_dark.svg">
</picture>

# Hyperglance Role [ARM]

This ARM template deploys a custom read-only role for Hyperglance at subscription scope to allow Hyperglance to poll a subscription.

## Deploy via Azure Portal

[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FRole%2Fazuredeploy.json)      [![Deploy To Azure US Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FRole%2Fazuredeploy.json)

## Deploy via Azure CLI

1. Ensure you have the necessary CLI tools installed and configured:
    * Azure CLI - [Install instructions](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
    * Log in to your Azure account:
      ```bash
      az login
      ```

2. Clone the repo or [download the zip](https://github.com/hyperglance/deploy/archive/refs/heads/master.zip)
	```bash
	 git clone https://github.com/hyperglance/deploy.git
	```

3. Navigate to the **Role** deployment directory

	```bash
	cd deploy/Azure/ARM/Role
    ```

4. Deploy the role template at subscription scope:

    ```bash
    az deployment sub create \
      --location <location> \
      --template-file azuredeploy.json
    ```

    *Please allow 1-2 minutes for the role to be created*

## Next Steps

__That's it - The Hyperglance custom role is now deployed!__

* [Follow this guide](https://support.hyperglance.com/knowledge/how-to-enable-cost-collection-in-azure) on how to setup an App Registration, attach this custom role and add the subscription to Hyperglance.

