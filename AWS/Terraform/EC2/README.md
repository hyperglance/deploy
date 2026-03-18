<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_light.svg">
  <img alt="Hyperglance logo" src="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_dark.svg">
</picture>

# Deploy Hyperglance to AWS EC2 [Terraform]

This Terraform template deploys Hyperglance as an AWS EC2 Instance.
> See also the equivalent CloudFormation [template](../EC2).

## Deploy via Terraform CLI

1. Ensure you have the necessary CLI tools installed and configured:
    * Terraform CLI - [Install instructions](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
    * AWS CLI - [Install instructions](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
    * Configure AWS CLI to have a valid login for the account you wish to deploy to - [See CLI quickstart](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

2. Clone the repo or [download the zip](https://github.com/hyperglance/deploy/archive/refs/heads/master.zip)
	```bash
	 git clone https://github.com/hyperglance/deploy.git
	```

3.  Navigate to the **EC2** deployment directory

	```bash
	cd deploy/AWS/Terraform/EC2
    ```

4. Edit the [myvars.tfvars](myvars.tfvars) file included in this directory and populate your variables accordingly

5. Deploy the stack:
	```bash
	 terraform init
	 terraform apply -var-file=myvars.tfvars
	```

6. Once complete, the following populated values will be returned:
	```bash
    hyperglance_username = "<username>"
    instance_id          = "<password>"
    private_dns          = "https://<private_dns>"
    private_ip           = "https://<private_ip>"
    public_dns           = "https://<public_dns>"
    public_ip            = "https://<public_ip>"
	```

   *Please allow up to 5 minutes for the EC2 instance to initialize before accessing the instance*


__That's it - Hyperglance is now deployed in your environment!__

## Log In And Activation
Visit: `https://IP_OF_YOUR_EC2_INSTANCE`

At the login screen the default login user details are:
* Username: `admin`
* Password: The instance-id of the instance e.g.  `i-0b22a22eec53b9321`

Follow the on-screen prompts to accept the EULA and activate the product with a commercial license key or start a trial.

## Connecting Accounts

This repository has an [IAM Role Template](../XAccount) you can deploy that grants all the permissions required to add an account to Hyperglance.  Follow the [online guide](https://support.hyperglance.com/knowledge/adding-new-aws-accounts-to-hyperglance) for more details.
