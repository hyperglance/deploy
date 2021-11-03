<img src="https://github.com/hyperglance/deploy/blob/master/files/b5dfbb6c-75c8-493b-8c5d-d68b3272cf0f.png" alt="Hyperglance Logo" />

# Hyperglance deployment

> Enable Hyperglance to automate, fix and optimize your cloud.

This repository contains Cloudformation stacks, that deploy an EC2 instance with Hyperglance pre-installed. Giving you the power to automate your cloud and fix configuration issues quickly & easily.

## Pre-Requisites

__If deploying using the CloudFormation web UI:__

1. Cloudformation UI access, in the account you wish to deploy to

__If deploying using the AWS CLI:__

1. AWS CLI - [Install instructions](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
2. Configure AWS CLI to have a valid login for the account you wish to deploy to - [AWS quick start](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

## Quick Start

## If using the Cloudformation Web UI

1. Follow the pre-requisite steps above.

2.  [<img src="https://github.com/hyperglance/deploy/blob/master/files/cloudformation-launch-stack.png" alt="Launch Hyperglance Cloudformation stack" />](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=HyperglanceDeployment&templateURL=https://hyperglance-deploy-repo-public.s3.amazonaws.com/CloudFormation/EC2/Hyperglance-EC2.json) and __populate the parameters when prompted in the UI__.
    *Please allow upto 5 minutes for the instance to provision*

## If using the AWS CLI

1. Follow the pre-requisite steps above.

2. Clone our repo or [download the zip](https://github.com/hyperglance/deploy/archive/refs/heads/master.zip)
	```bash
	 git clone https://github.com/hyperglance/deploy.git
	```

4.  Navigate to the XAccount deployment directory 
	
	```bash
	cd deploy/CloudFormation/EC2
    ```

5. Edit [cli-input.yaml](CloudFormation/EC2/cli-input.yaml) to fit your requirements

6. Deploy the stack:

    ```bash
    aws cloudformation create-stack --cli-input-yaml file://cli-input.yaml
    ```

    *Now allow upto 5 minutes for the instance to initialize*
    
    Make a note of the StackId value, which is the ARN of the stack generated - e.g. arn:aws:cloudformation:eu-west-3:123456789012:stack/HyperglanceDeployment/608c1be0-3c83-11ec-b50b-0afabf21c8aa

7. Query the AWS API for your Cloudformation stack outputs, which will include the DNS or IP's required to access Hyperglance:

    ```bash
    aws cloudformation describe-stacks --stack-name "<ARN value output from the above query>" --query 'Stacks[*].Outputs[*]'
    ```

__That's it - Hyperglance is now deployed in your environment and ready for configuration!__

* Access the web UI by using the values provided by Cloudformation, such as HyperglancePublicIP or HyperglancePublicDNS.
* Follow our guide [here](https://support.hyperglance.com/knowledge/how-to-apply-a-new-license) to apply your license

## Questions

You can find a wealth of support documents, FAQs and guides on our [website](https://support.hyperglance.com).<br />
If something isn't right or you need further support, [log a ticket](https://support.hyperglance.com/knowledge/kb-tickets/new) with us and we'll be in touch to assist you.

## Contributions
Are welcome!
