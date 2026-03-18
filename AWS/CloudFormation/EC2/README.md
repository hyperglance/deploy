<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_light.svg">
  <img alt="Hyperglance logo" src="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_dark.svg">
</picture>

# Deploy Hyperglance to AWS EC2 [CloudFormation]

This CloudFormation template deploys Hyperglance as an AWS EC2 Instance.

## Deploy via AWS Console

1.  [<img src="https://github.com/hyperglance/deploy/blob/master/files/cloudformation-launch-stack.png" alt="Launch Hyperglance CloudFormation stack" />](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=HyperglanceDeployment&templateURL=https://hyperglance-deploy-repo-public.s3.amazonaws.com/AWS/CloudFormation/EC2/Hyperglance-EC2.json)
2. Follow this [step-by-step guide](https://support.hyperglance.com/knowledge/deploying-hyperglance-in-your-aws-vpc) to fill in the CloudFormation inputs form.

## Deploy via AWS CLI

1. Ensure you have the necessary CLI tools installed and configured:
    * AWS CLI - [Install instructions](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
    * Configure AWS CLI to have a valid login for the account you wish to deploy to - [See CLI quickstart](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

2. Clone the repo or [download the zip](https://github.com/hyperglance/deploy/archive/refs/heads/master.zip)
	```bash
	 git clone https://github.com/hyperglance/deploy.git
	```

3.  Navigate to the **EC2** deployment directory

	```bash
	cd deploy/AWS/CloudFormation/EC2
    ```

4. Edit [cli-input.yaml](cli-input.yaml) to fit your requirements

5. Deploy the stack:

    ```bash
    aws cloudformation create-stack --cli-input-yaml file://cli-input.yaml
    ```

    *Now allow up to 5 minutes for the instance to initialize*

    Make a note of the StackId value, which is the ARN of the stack generated - e.g. arn:aws:cloudformation:eu-west-3:123456789012:stack/HyperglanceDeployment/608c1be0-3c83-11ec-b50b-0afabf21c8aa

6. Query the AWS API for your CloudFormation stack outputs, which will include the DNS or IP's required to access Hyperglance:

    ```bash
    aws cloudformation describe-stacks --stack-name "<ARN value output from the above query>" --query 'Stacks[*].Outputs[*]'
    ```

__That's it - Hyperglance is now deployed in your environment!__

## Log In And Activation
Visit: `https://IP_OF_YOUR_EC2_INSTANCE`

At the login screen the default login user details are:
* Username: `admin`
* Password: The instance-id of the instance e.g.  `i-0b22a22eec53b9321`

Follow the on-screen prompts to accept the EULA and activate the product with a commercial license key or start a trial.

## Connecting Accounts

This repository has an [IAM Role Template](../XAccount) you can deploy that grants all the permissions required to add an account to Hyperglance.  Follow the [online guide](https://support.hyperglance.com/knowledge/adding-new-aws-accounts-to-hyperglance) for more details.

