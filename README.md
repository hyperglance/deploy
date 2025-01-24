<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_dark.svg">
  <img alt="Hyperglance logo" src="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_dark.svg">
</picture>

# Hyperglance Deployment

* [Deploy to AWS](#deploy-to-aws)
* [Deploy to Kubernetes using Helm](https://github.com/hyperglance/helm-chart)

## Deploy to AWS

### EC2

1. [Sign up for a license](https://www.hyperglance.com/get-started/)

2. Choose your IaC - [Terraform](AWS/Terraform/EC2) or [CloudFormation](AWS/CloudFormation/EC2)

3. [Apply the key to your Hyperglance deployment](https://support.hyperglance.com/knowledge/how-to-apply-a-new-license)

### ECS

> **_NOTE:_**  The ECS-based deployments are not regularly maintained. As such you may experience issues when using them. We hope this will serve as an example for your own IaC efforts and if you are not able to resolve any problems yourself feel free to reach out to our support desk. For the best experience we recommend you use an actively maintained deployment option, see: [EC2 Terraform](AWS/Terraform/EC2), [EC2 Cloudformation](AWS/Cloudformation/EC2)  or our [Helm chart](https://github.com/hyperglance/helm-chart) which supports EKS and other k8s distributions.

1. [Sign up for a license](https://www.hyperglance.com/get-started/)

2. Choose your deployment method - [ECS using RDS](AWS/Terraform/ECS_RDS) or [ECS only](AWS/Terraform/ECS)

3. [Apply the key to your Hyperglance deployment](https://support.hyperglance.com/knowledge/how-to-apply-a-new-license)

### EKS

1. [Sign up for a license](https://www.hyperglance.com/get-started/)

2. See our dedicated [helm chart repository](https://github.com/hyperglance/helm-chart) for detailed deployment information.

3. [Apply your key into Hyperglance](https://support.hyperglance.com/knowledge/how-to-apply-a-new-license)

## Deploy to Azure

1. [Sign up for a license](https://www.hyperglance.com/get-started/)

2. Deploy Hyperglance using one of the buttons below:

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FVM%2Fazuredeploy.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FVM%2FcreateUiDefinition.json)        [![Deploy To Azure US Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FVM%2Fazuredeploy.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FVM%2FcreateUiDefinition.json)

3. Optional. Create a custom read only role for Hyperglance, or follow the instructions [here](https://support.hyperglance.com/knowledge/how-to-enable-cost-collection-in-azure)

[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FRole%2Fazuredeploy.json)      [![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhyperglance%2Fdeploy%2Fmaster%2FAzure%2FARM%2FRole%2Fazuredeploy.json)

4. [Apply your key into Hyperglance](https://support.hyperglance.com/knowledge/how-to-apply-a-new-license)