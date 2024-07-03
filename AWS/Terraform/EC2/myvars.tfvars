######################################################################
# The below variables require changing according to your environment #
######################################################################

# [Required] AWS Region to deploy into
region = "<AWS REGION>"

# [Required] The subnet ID to deploy Hyperglance into
subnet_id = "<VPC SUBNET ID>"

# [Required] Assign a public IP address to the EC2 instance?
# Use true unless you are using a private subnet deployment option - https://support.hyperglance.com/knowledge/hyperglance-running-in-highly-secure-aws-environments
assign_public_ip = true

# [Required] Security Group: IP CIDR to access Hyperglance instance
allow_https_inbound_cidr = ["<IP CIDR 1>", "<IP CIDR 2>"] # For UI/API access e.g. ["1.1.1.1/32","1.0.0.1/32"]
allow_ssh_inbound_cidr   = ["<IP CIDR 1>", "<IP CIDR 2>"] # For SSH access e.g. ["1.1.1.1/32","1.0.0.1/32"]

######################################################################
# ~~~~~~~~~~~~~~~~~~~~ End of required variables~~~~~~~~~~~~~~~~~~~~~#
######################################################################

# [Optional] A pre-existing SSH Key Pair to use. Leave commented-out if using SSM
# key_name = "<ssh_keypair_name>"

# [Optional] Instance type - https://support.hyperglance.com/knowledge/sizing-guide
# instance_type = "r5a.xlarge"

# [Optional] EC2 instance tags
# ec2_instance_tags = {
#   "Name" = "Hyperglance"
# }

# [optional] Override AMI IDs per region
# Use to specify AMIs from the AWS Marketplace, those IDs are unique to your subscribed account and for each region.
#image_ids = {
# "us-east-1" = "ami-0add6e9dfe8107698"
# "us-east-2" = "ami-03a1b5a830ca5553f"
# ... etc
#}
