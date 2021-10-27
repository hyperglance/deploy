<img src="https://github.com/hyperglance/deploy/blob/master/files/b5dfbb6c-75c8-493b-8c5d-d68b3272cf0f.png" alt="Hyperglance Logo" />

# Hyperglance deployment

> Enable Hyperglance to automate, fix and optimize your cloud.

This repository contains Terraform configurations, that deploy an EC2 instance with Hyperglance pre-installed. Giving you the power to automate your cloud and fix configuration issues quickly & easily.

## Pre-Requisites

Before you can deploy automations you will need:
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
	cd deploy/Terraform/EC2
    ```

5. Create myvars.tfvars file and prepopulate your variables - here's an example:
    ```bash
    # myvars.tfvars

    # AWS Region to deploy resources in
    region = "<AWS region>"
    
    # EC2 instance type - https://support.hyperglance.com/knowledge/sizing-guide
    instance_type = "<instance_type>" # Defaults to t2.large if omitted
    
    # EC2 instance custom tags
    ec2_instance_tags = {"Name" = "<ec2_instance_name>"} # Default to "Name" = "Hyperglance Deployment" if omitted

    # IP CIDR to access Hyperglance instances
    allow_https_inbound_cidr     = "<your_IP_CIDR>" # UI/API e.g. 1.1.1.1/32
    allow_ssh_inbound_cidr = "<your_IP_CIDR>"    # SSH e.g. 1.1.1.1/32
    
    # EC2 instance parameters
    key_name = "<ssh_keypair_name>" # Existing SSH Key Pair loaded in AWS
    
    subnet_id        = "<AWS subnet ID>" # Existing subnet for EC2 instance to deploy in
    assign_public_ip = <true/false>              # Assign a public IP address to instance (bool)
    ```
6. Deploy the stack:
	```
	 terraform init
	 terraform apply -var-file=myvars.tfvars
	```

6. Once complete, the following populated values will be returned:
	```bash
    hyperglance_username = "<username>"
    instance_id          = "<password>"
    private_dns          = "https://<private_dns>"
    private_ip           = "https://<private_ip>"
    public_dns           = "https://public_dns>"
    public_ip            = "https://<public_ip>"
	```
 
   *Please allow upto 5 minutes for the EC2 instance to initialize before access the instance*
	


__That's it - Hyperglance is now deployed in your environment and ready for configuration!__

* Access the web UI by clicking the link provided by Terraform for public_ip or public_dns.
* Follow our guide [here](https://support.hyperglance.com/knowledge/how-to-apply-a-new-license) to apply your license

## Questions

You can find a wealth of support documents, FAQs and guides on our [website](https://support.hyperglance.com).<br />
If something isn't right or you need further support, [log a ticket](https://support.hyperglance.com/knowledge/kb-tickets/new) with us and we'll be in touch to assist you.

## Contributions
Are welcome!
