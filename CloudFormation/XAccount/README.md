<img src="https://github.com/hyperglance/deploy/blob/master/files/b5dfbb6c-75c8-493b-8c5d-d68b3272cf0f.png" alt="Hyperglance Logo" />

# Hyperglance cross-account IAM role deployment

This Cloudformation template deploys an IAM role and associated policy, with the [required permissions](https://support.hyperglance.com/knowledge/aws-iam-policy-requirements) to enable Hyperglance to poll resources outside the subscription the instance is hosted in.

## Pre-Requisites

1. Make a note of the ARN of the role associated with the Hyperglance instance. You can find this by navigating to the EC2 instance in the UI and selecting the instance profile attached - the role ARN will look like this, if you've deployed using our Terraform or Cloudformation templates:

```bash 
 arn:aws:iam::123456789012:role/Hyperglance-HGRole-18W6XUMBBF2CA
 ```

__If deploying using the Cloudformation web UI:__

2. Cloudformation UI access, in the account you wish to deploy to

__If deploying using the AWS CLI:__

2. AWS CLI - [Install instructions](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
3. Configure AWS CLI to have a valid login for the account you wish to deploy to - [AWS quick start](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

## Quick Start

## If using the Cloudformation Web UI

1. Follow the pre-requisite steps above.

2.  [<img src="https://github.com/hyperglance/deploy/blob/master/files/cloudformation-launch-stack.png" alt="Launch Hyperglance Cloudformation stack" />](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=HyperglanceXAccountIAMRole&templateURL=https://hyperglance-cloudformation-templates-public.s3.amazonaws.com/deploy/xaccount/Hyperglance-xaccount-role.json) and __populate with the IAM role ARN of the Hyperglance instance__ noted previously and submit the stack for creation
    *Please allow 1-2 minutes for the role to be created by CloudFormation*

3. Note down the ARN of the role created by Cloudformation under the output tab

## If using the AWS CLI

1. Follow the pre-requisite steps above.

2. Clone our repo or [download the zip](https://github.com/hyperglance/deploy/archive/refs/heads/master.zip)
	```bash
	 git clone https://github.com/hyperglance/deploy.git
	```

4.  Navigate to the XAccount deployment directory 
	
	```
	cd deploy/CloudFormation/XAccount
    ```

5. Deploy the stack, __substituting <Hyperglance_instance_role> with the IAM role ARN of the Hyperglance instance__ noted previously:
	```
	aws cloudformation create-stack --stack-name HyperglanceXAccountRole --template-body file://Hyperglance-xaccount-role.json --parameters ParameterKey="HyperglanceRoleARN",ParameterValue="<Hyperglance_instance_role>" --capabilities CAPABILITY_IAM
	```
    *Please allow 1-2 minutes for the role to be created by CloudFormation*

6. Grab the ARN of the XAccount role created:
   ```bash
   aws cloudformation describe-stacks --stack-name HyperglanceXAccountRole --query "Stacks[0].Outputs[?OutputKey=='HyperglanceXAccountRole'].OutputValue" --output text
   ```
<br />

__That's it - The Hyperglance XAccount role is now deployed in the subscription!__

* [Follow these instructions](https://support.hyperglance.com/knowledge/adding-new-aws-accounts-to-hyperglance#first_account_running_in_aws) to add the account to Hyperglance, using the new cross-account ARN you have created.

## Questions

You can find a wealth of support documents, FAQs and guides on our [website](https://support.hyperglance.com).<br />
If something isn't right or you need further support, [log a ticket](https://support.hyperglance.com/knowledge/kb-tickets/new) with us and we'll be in touch to assist you.

## Contributions
Are welcome!
