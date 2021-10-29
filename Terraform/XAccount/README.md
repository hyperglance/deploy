<img src="https://github.com/hyperglance/deploy/blob/master/files/b5dfbb6c-75c8-493b-8c5d-d68b3272cf0f.png" alt="Hyperglance Logo" />

# Hyperglance cross-account IAM role deployment

This Terraform configuration deploys an IAM role and associated policy, with the [required permissions](https://support.hyperglance.com/knowledge/aws-iam-policy-requirements) to enable Hyperglance to poll resources outside the subscription the instance is hosted in.

## Pre-Requisites

Before you can deploy, you will need:

1. Make a note of the ARN of the role associated with the Hyperglance instance. You can find this by navigating to the EC2 instance in the UI and selecting the instance profile attached - the role ARN will look like this, if you've deployed using our Terraform or Cloudformation templates:

```bash 
 arn:aws:iam::123456789012:role/Hyperglance-HGRole-18W6XUMBBF2CA
 ```
2. Terraform CLI - [Install instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli)
3. AWS CLI - [Install instructions](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
4. Configure AWS CLI to have a valid login for the account you wish to deploy to - [AWS quick start](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

## Quick Start

1. Follow the pre-requisite steps above.

2. Clone our repo or [download the zip](https://github.com/hyperglance/deploy/archive/refs/heads/master.zip)
	```bash
	 git clone https://github.com/hyperglance/deploy.git
	```

4.  Navigate to the terraform deployment directory 
	
	```
	cd deploy/Terraform/XAccount
    ```

5. Edit the [myvars.tfvars](myvars.tfvars) file included in this directory and populate your variables accordingly
 
6. Deploy the stack:
	```
	 terraform init
	 terraform apply -var-file=myvars.tfvars
	```

6. Once complete, the following populated values will be returned:
	```bash
    hyperglance_xaccount_role_arn = "<ARN of XAccount role>
	```
 

__That's it - The Hyperglance XAccount role is now deployed in the subscription!__

* [Follow these instructions](https://support.hyperglance.com/knowledge/adding-new-aws-accounts-to-hyperglance#first_account_running_in_aws) to add the account to Hyperglance, using the new cross-account ARN you have created.

## Questions

You can find a wealth of support documents, FAQs and guides on our [website](https://support.hyperglance.com).<br />
If something isn't right or you need further support, [log a ticket](https://support.hyperglance.com/knowledge/kb-tickets/new) with us and we'll be in touch to assist you.

## Contributions
Are welcome!
