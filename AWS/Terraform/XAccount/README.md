<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_light.svg">
  <img alt="Hyperglance logo" src="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_dark.svg">
</picture>

# Hyperglance IAM Role [Terraform]

This Terraform template deploys an IAM role with [read-only policy](https://support.hyperglance.com/knowledge/aws-iam-policy-requirements) and cross-account trust policy to allow Hyperglance to poll an AWS account.

## Before You Start

Make a note of the ARN of the role associated with the Hyperglance instance. You can find this by navigating to the EC2 instance in the AWS Console and selecting the instance profile attached. If you deployed Hyperglance using one of our templates then the role ARN will look like this:

```bash
 arn:aws:iam::123456789012:role/Hyperglance-HGRole-18W6XUMBBF2CA
 ```

## Deploy via Terraform CLI

1. Ensure you have the necessary CLI tools installed and configured:
    * Terraform CLI - [Install instructions](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
    * AWS CLI - [Install instructions](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
    * Configure AWS CLI to have a valid login for the account you wish to deploy to - [See CLI quickstart](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

2. Clone our repo or [download the zip](https://github.com/hyperglance/deploy/archive/refs/heads/master.zip)
	```bash
	 git clone https://github.com/hyperglance/deploy.git
	```

3.  Navigate to the **XAccount** deployment directory

	```bash
	cd deploy/AWS/Terraform/XAccount
    ```

4. Edit the [myvars.tfvars](myvars.tfvars) file included in this directory and populate your variables accordingly

5. Deploy the stack:
	```bash
	 terraform init
	 terraform apply -var-file=myvars.tfvars
	```

6. Once complete, the following populated values will be returned:
	```bash
    hyperglance_xaccount_role_arn = "<ARN of XAccount role>"
	```

## Next Steps
__That's it - The Hyperglance XAccount role is now deployed in the account!__

* [Follow these instructions](https://support.hyperglance.com/knowledge/adding-new-aws-accounts-to-hyperglance#first_account_running_in_aws) to add the account to Hyperglance, using the new cross-account ARN you have created.

