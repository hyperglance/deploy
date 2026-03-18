<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../../files/hyperglance_logo_dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="../../../files/hyperglance_logo_light.svg">
  <img alt="Hyperglance logo" src="../../../files/hyperglance_logo_dark.svg">
</picture>

# Deploy Hyperglance to Azure [ARM]

This ARM template deploys Hyperglance as an Azure Virtual Machine.

## Deploy via Azure Portal

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FVM%2Fazuredeploy.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FVM%2FcreateUiDefinition.json)        [![Deploy To Azure US Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FVM%2Fazuredeploy.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FVM%2FcreateUiDefinition.json)

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

3. Navigate to the **VM** deployment directory

	```bash
	cd deploy/Azure/ARM/VM
    ```

4. Deploy the VM template to your resource group:

    ```bash
    az deployment group create \
      --resource-group <resource-group-name> \
      --template-file azuredeploy.json
    ```

    *Now allow up to 5 minutes for the VM to initialize*

## Log In And Activation

Visit: `https://<public-ip-or-hostname>`

At the login screen the default login user details are:
* Username: `admin`
* Password: The Computer Name that you assigned to the VM e.g.  `hyperglance-vm`

Follow the on-screen prompts to accept the EULA and activate the product with a commercial license key or start a trial.

## Connecting Subscriptions

This repository has an [Custom Role ARM Template](../Role) you can deploy that grants all the permissions required to add a subscription to Hyperglance.  Follow the [online guide](https://support.hyperglance.com/knowledge/azure-collector-setup) for more details.