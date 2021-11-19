<img src="https://github.com/hyperglance/deploy/blob/master/files/b5dfbb6c-75c8-493b-8c5d-d68b3272cf0f.png" alt="Hyperglance Logo" />

# Hyperglance deployment

> Enable Hyperglance to automate, fix and optimize your cloud.

This repository contains Terraform configurations, that deploy an ECS cluster backed by FARGATE, ECS task (Hyperglance), EFS mounts to persist required data, an Aurora Serverless RDS cluster and associated IAM roles and policies. Giving you the power to automate your cloud and fix configuration issues quickly & easily.

## Pre-Requisites

Before you can deploy, you will need:
1. Terraform CLI - [Install instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli)
2. AWS CLI - [Install instructions](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
3. Configure AWS CLI to have a valid login for the account you wish to deploy to - [AWS quick start](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

## Quick Start

1. Follow the pre-requisite steps above.

2. Clone our repo or [download the zip](https://github.com/hyperglance/deploy/archive/refs/heads/master.zip)
	```bash
	 git clone https://github.com/hyperglance/deploy.git
	```

4.  Navigate to the terraform deployment directory 
	
	```
	cd deploy/AWS/Terraform/ECS_RDS
    ```

5. Edit the [myvars.tfvars](myvars.tfvars) file included in this directory and populate your variables accordingly
 
6. Deploy the stack:
	```
	 terraform init
	 terraform apply -var-file=myvars.tfvars
	```

6. Once complete, the following populated values will be returned:
	```bash
	alb_address = "<ALB ADDRESS>"
	note = "Allow 5-10 minutes for the ECS container to become available on the ALB"
	```

__That's it - Hyperglance is now deployed in your environment and ready for configuration!__

## Login

Login using the hostname of the ALB. Default credentials:

Username: admin  
Password: admin

__It is highly recommended you [change the password](https://support.hyperglance.com/knowledge/how-to-change-hyperglance-login-password) once you login.__

* Follow our guide [here](https://support.hyperglance.com/knowledge/how-to-apply-a-new-license) to apply your license
* Follow our guide [here](https://support.hyperglance.com/knowledge/adding-new-aws-accounts-to-hyperglance) to add your first AWS account

## Pulling updates

Using the AWS CLI, trigger a new deployment:

```bash
aws ecs update-service --cluster <cluster name> --service <service name> --force-new-deployment --region <region>
```

## Questions

You can find a wealth of support documents, FAQs and guides on our [website](https://support.hyperglance.com).<br />
If something isn't right or you need further support, [log a ticket](https://support.hyperglance.com/knowledge/kb-tickets/new) with us and we'll be in touch to assist you.

## Contributions
Are welcome!
