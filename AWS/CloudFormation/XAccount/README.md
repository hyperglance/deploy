<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../../files/hyperglance_logo_dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="../../../files/hyperglance_logo_light.svg">
  <img alt="Hyperglance logo" src="../../../files/hyperglance_logo_light.svg">
</picture>

# Hyperglance IAM Role [CloudFormation]

This Cloudformation template deploys an IAM role with [read-only policy](https://support.hyperglance.com/knowledge/aws-iam-policy-requirements) and cross-account trust policy to allow Hyperglance to poll an AWS account.

## Before You Start

Make a note of the ARN of the role associated with the Hyperglance instance. You can find this by navigating to the EC2 instance in the AWS Console and selecting the instance profile attached. If you deployed Hyperglance using one of our templates then the role ARN will look like this:

```bash 
 arn:aws:iam::123456789012:role/Hyperglance-HGRole-18W6XUMBBF2CA
 ```

## Deploy via AWS Console

1.  [<img src="https://github.com/hyperglance/deploy/blob/master/files/cloudformation-launch-stack.png" alt="Launch Hyperglance Cloudformation stack" />](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=HyperglanceXAccountIAMRole&templateURL=https://hyperglance-deploy-repo-public.s3.amazonaws.com/AWS/CloudFormation/XAccount/Hyperglance-xaccount-role.json) and __populate with the IAM role ARN of the Hyperglance instance__ noted previously and submit the stack for creation
    *Please allow 1-2 minutes for the role to be created by CloudFormation*

2. Note down the ARN of the role created by Cloudformation under the output tab

## Deploy via AWS CLI

1. Ensure you have the necessary CLI tools installed and configured:
    * AWS CLI - [Install instructions](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
    * Configure AWS CLI to have a valid login for the account you wish to deploy to - [See CLI quickstart](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

2. Clone the repo or [download the zip](https://github.com/hyperglance/deploy/archive/refs/heads/master.zip)
	```bash
	 git clone https://github.com/hyperglance/deploy.git
	```

3.  Navigate to the **XAccount** deployment directory

	```bash
	cd deploy/AWS/CloudFormation/XAccount
    ```

4. Deploy the stack, __substituting <Hyperglance_instance_role> with the IAM role ARN of the Hyperglance instance__ noted previously:
	```bash
	aws cloudformation create-stack --stack-name HyperglanceXAccountRole --template-body file://Hyperglance-xaccount-role.json --parameters ParameterKey="HyperglanceRoleARN",ParameterValue="<Hyperglance_instance_role>" --capabilities CAPABILITY_IAM
	```
    *Please allow 1-2 minutes for the role to be created by CloudFormation*

5. Grab the ARN of the XAccount role created:
   ```bash
   aws cloudformation describe-stacks --stack-name HyperglanceXAccountRole --query "Stacks[0].Outputs[?OutputKey=='HyperglanceXAccountRole'].OutputValue" --output text
   ```


## Next Steps
__That's it - The Hyperglance XAccount role is now deployed in the account!__

* [Follow these instructions](https://support.hyperglance.com/knowledge/adding-new-aws-accounts-to-hyperglance#first_account_running_in_aws) to add the account to Hyperglance, using the new cross-account ARN you have created.
