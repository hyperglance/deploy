######################################################################
# The below variables require changing according to your environment #
######################################################################

# [Required] AWS Region to deploy into
region = "<AWS REGION>"

# [Required] An existing VPC for the resources to deploy into
vpc_id = "<VPC ID>"

# [Required] Security Group: IP CIDR to access Hyperglance instance
allow_https_inbound_cidr = "<IP CIDR>" # For UI/API access e.g. 1.1.1.1/32

######################################################################
# ~~~~~~~~~~~~~~~~~~~~ End of required variables~~~~~~~~~~~~~~~~~~~~~#
######################################################################

# [Optional] Set of subnets to deploy resources to
# subnet_ids = ["subnet-0eb38f44","subnet-ca0f16b2"]