<img src="https://github.com/hyperglance/deploy/blob/master/files/b5dfbb6c-75c8-493b-8c5d-d68b3272cf0f.png" alt="Hyperglance Logo" />

# Hyperglance deployment

> Enable Hyperglance to automate, fix and optimize your cloud.

This repository contains Cloudformation stacks, that deploy an EC2 instance with Hyperglance pre-installed. Giving you the power to automate your cloud and fix configuration issues quickly & easily.

## Pre-Requisites

__If deploying using the CloudFormation web UI:__

1. Cloudformation UI access, in the account you wish to deploy to

## Quick Start

## If using the Cloudformation Web UI

1. Follow the pre-requisite steps above.

2.  [<img src="https://github.com/hyperglance/deploy/blob/master/files/cloudformation-launch-stack.png" alt="Launch Hyperglance Cloudformation stack" />](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=HyperglanceDeployment&templateURL=https://hyperglance-deploy-repo-public.s3.amazonaws.com/CloudFormation/EC2/Hyperglance-EC2.json) and __populate the parameters when prompted in the UI__.
    *Please allow upto 5 minutes for the instance to provision after submitting the stack for creation*

__That's it - Hyperglance is now deployed in your environment and ready for configuration!__

* Access the web UI by clicking the link provided by Cloudformation in the outputs tab for for public_ip or public_dns.
* Follow our guide [here](https://support.hyperglance.com/knowledge/how-to-apply-a-new-license) to apply your license

## Questions

You can find a wealth of support documents, FAQs and guides on our [website](https://support.hyperglance.com).<br />
If something isn't right or you need further support, [log a ticket](https://support.hyperglance.com/knowledge/kb-tickets/new) with us and we'll be in touch to assist you.

## Contributions
Are welcome!
