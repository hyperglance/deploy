<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_dark.svg">
  <img alt="Hyperglance logo" src="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_dark.svg">
</picture>

> **_NOTE:_**  The ECS-based deployments are not regularly maintained. As such you may experience issues when using them. We hope this will serve as an example for your own IaC efforts and if you are not able to resolve any problems yourself feel free to reach out to our support desk. For the best experience we recommend you use an actively maintained deployment option, see: [EC2](../EC2) or our [Helm chart](https://github.com/hyperglance/helm-chart) which supports EKS and other k8s distributions.

# Hyperglance deployment

> Enable Hyperglance to automate, fix and optimize your cloud.

This repository contains Terraform configurations, that deploy an ECS cluster backed by FARGATE, 2x ECS tasks (Hyperglance + PostgreSQL), EFS mounts to persist required data and associated IAM roles and policies. Giving you the power to automate your cloud and fix configuration issues quickly & easily.

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

3. Navigate to the terraform deployment directory

 ```bash
 cd deploy/AWS/Terraform/ECS
 ```

4. Edit the [myvars.tfvars](myvars.tfvars) file included in this directory and populate your variables accordingly

5. Deploy the stack:

  ```bash
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

You can find a wealth of support documents, FAQs and guides on our [website](https://support.hyperglance.com).  
If something isn't right or you need further support, [log a ticket](https://support.hyperglance.com/knowledge/kb-tickets/new) with us and we'll be in touch to assist you.

## Contributions

Are welcome!
