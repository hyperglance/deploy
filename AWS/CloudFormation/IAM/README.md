<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../../files/hyperglance_logo_dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="../../../files/hyperglance_logo_light.svg">
  <img alt="Hyperglance logo" src="../../../files/hyperglance_logo_dark.svg">
</picture>

# Hyperglance IAM Role Templates [CloudFormation]

Choose the template that matches what you are connecting in Hyperglance:

| Scenario | Template | IAM permissions granted |
|---|---|---|
| **Single account** — inventory | [`Hyperglance-account-role.json`](#single-account--aws-organizations-management-account) | Read-only access to all supported services |
| **AWS Organizations** — management account | [`Hyperglance-account-role.json`](#single-account--aws-organizations-management-account) (same template) | Read-only access + Organizations read + `sts:AssumeRole` into member accounts |
| **AWS Organizations** — member accounts | [`Hyperglance-member-account-role.json`](#aws-organizations--member-accounts) (via StackSets) | Read-only access to all supported services |
| **S3 cost source** — billing exports only | [`Hyperglance-cost-bucket-role.json`](#s3-cost-source) | `s3:GetObject/ListBucket` scoped to the named bucket only |
| **Externally-hosted Hyperglance** (Azure/GCP) | [`Hyperglance-user.json`](#externally-hosted-hyperglance-azuregcp) | `sts:AssumeRole` on `HyperglanceReadOnly` and `HyperglanceCostBucket` only — deploy once, use ARN in role templates above |

---

## Single account / AWS Organizations management account

**Template:** `Hyperglance-account-role.json`

Creates the `HyperglanceReadOnly` IAM role for any account that Hyperglance connects to directly. This covers both single standalone accounts and AWS Organizations management accounts — the template is identical in both cases. It grants:

- Read-only access to inventory all supported AWS services
- `ce:Get*` (Cost Explorer) and `savingsplans:DescribeSavingsPlans` to discover existing Reserved Instance / Savings Plan commitments (utilization, coverage) and fetch Savings Plan purchase recommendations
- `organizations:Describe*` and `organizations:List*` to enumerate the organisation structure (harmless on accounts not in an org)
- `sts:AssumeRole` permission to assume `HyperglanceReadOnly` in member accounts (unused on single accounts)

**For a single account,** provide your Hyperglance EC2 instance role ARN as `HyperglancePrincipalARN`.

**For AWS Organizations,** deploy this template in the management account, then deploy `Hyperglance-member-account-role.json` into each member account via StackSets (see below). Provide the management account role ARN from this stack's Outputs as the `HyperglancePrincipalARN` parameter when deploying the member account stacks.

### Deploy via AWS Console

[![Launch Stack](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=HyperglanceAccountRole&templateURL=https://hyperglance-deploy-repo-public.s3.amazonaws.com/AWS/CloudFormation/IAM/Hyperglance-account-role.json)

### Deploy via AWS CLI

```bash
aws cloudformation deploy \
  --template-file Hyperglance-account-role.json \
  --stack-name HyperglanceAccountRole \
  --parameter-overrides HyperglancePrincipalARN=<hyperglance-ec2-role-arn> \
  --capabilities CAPABILITY_NAMED_IAM
```

After deployment, copy the role ARN from the stack Outputs and:
1. Paste it into Hyperglance when prompted for the Role ARN.
2. _(AWS Organizations only)_ Use it as the `HyperglancePrincipalARN` parameter when deploying member account stacks via StackSets.

---

## AWS Organizations — member accounts

**Template:** `Hyperglance-member-account-role.json`

Creates the `HyperglanceReadOnly` IAM role in each member account, granting the management account role permission to assume in and inventory that account's resources. Deploy via StackSets using the management account role ARN (from the `Hyperglance-account-role.json` stack Outputs) as `HyperglancePrincipalARN`.

### Deploy to member accounts via StackSets

1. Deploy the management account template first (see above) and note the role ARN from the stack Outputs.
2. Navigate to [CloudFormation StackSets](https://us-east-1.console.aws.amazon.com/cloudformation/home#/stacksets) in the AWS Console.
3. Create a new StackSet using template URL:
   ```
   https://hyperglance-deploy-repo-public.s3.amazonaws.com/AWS/CloudFormation/IAM/Hyperglance-member-account-role.json
   ```
4. Set `HyperglancePrincipalARN` to the ARN of the `HyperglanceReadOnly` role in the management account.
5. Deploy to your target organizational unit or the entire organisation root.

### Deploy via AWS CLI (single member account)

```bash
aws cloudformation deploy \
  --template-file Hyperglance-member-account-role.json \
  --stack-name HyperglanceMemberAccountRole \
  --parameter-overrides HyperglancePrincipalARN=<management-account-role-arn> \
  --capabilities CAPABILITY_NAMED_IAM
```

---

## S3 cost source

**Template:** `Hyperglance-cost-bucket-role.json`

Creates the `HyperglanceCostBucket` IAM role with **only** the permissions needed to read billing exports from a specific S3 bucket:

- `s3:ListBucket` — scoped to the named bucket
- `s3:GetObject` — scoped to objects in the named bucket

This role does **not** grant access to EC2, RDS, networking services, or any other inventory data. Use it when connecting a cost source in Hyperglance without full account inventory. Deploy the role in the same account as the S3 bucket.

To grant access to additional billing buckets after deployment, edit the `HyperglanceCostBucket` role policy in the IAM console and add further `s3:ListBucket` and `s3:GetObject` statements.

### Deploy via AWS Console

[![Launch Stack](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=HyperglanceCostBucketRole&templateURL=https://hyperglance-deploy-repo-public.s3.amazonaws.com/AWS/CloudFormation/IAM/Hyperglance-cost-bucket-role.json)

### Deploy via AWS CLI

```bash
aws cloudformation deploy \
  --template-file Hyperglance-cost-bucket-role.json \
  --stack-name HyperglanceCostBucketRole \
  --parameter-overrides HyperglancePrincipalARN=<hyperglance-ec2-role-arn> CostBucketName=<bucket-name> \
  --capabilities CAPABILITY_NAMED_IAM
```

---

## Externally-hosted Hyperglance (Azure/GCP)

**Template:** `Hyperglance-user.json`

When Hyperglance is hosted outside AWS (on Azure, GCP, or on-premises), there is no EC2 instance role to use as the trust principal. Instead, deploy this template **once** in any convenient AWS account to create the `HyperglanceUser` IAM user. The user has no direct resource permissions — it may only assume `HyperglanceReadOnly` and `HyperglanceCostBucket` roles in target accounts.

Then, when deploying any of the role templates above, provide the `HyperglanceUser` ARN (shown in this stack's Outputs) as the `HyperglancePrincipalARN` parameter.

After deployment, create access keys for the user in the IAM console and enter them in Hyperglance.

### Deploy via AWS Console

[![Launch Stack](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=HyperglanceUser&templateURL=https://hyperglance-deploy-repo-public.s3.amazonaws.com/AWS/CloudFormation/IAM/Hyperglance-user.json)

### Deploy via AWS CLI

```bash
aws cloudformation deploy \
  --template-file Hyperglance-user.json \
  --stack-name HyperglanceUser \
  --capabilities CAPABILITY_NAMED_IAM
```

---

## Next steps

Once the stack is deployed, copy the role ARN from the CloudFormation **Outputs** tab and paste it into Hyperglance when prompted.

For full IAM policy documentation see the [Hyperglance knowledge base](https://support.hyperglance.com/knowledge/aws-iam-policy-requirements).
