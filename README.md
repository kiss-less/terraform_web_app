# web_app

Author: https://github.com/kiss-less

## Overview
This module deploys VPC, public and private subnets, ELB, routing tables, IGW, NAT instance, Bastion host to securely contact the Frontend and Backend instances that are deployed to the private subnets.

## Prerequisites
- terraform v1.8.5
- aws terraform provider 5.54.1
- tls terraform provider 4.0.5
- AWS credentials configured (preferrably via environment variables)

## Usage

### With a remote state:

1. Create an s3 bucket that is going to store the terraform state
2. Uncomment configuration of the `providers.tf`
3. Make sure you have the AWS credentials configured
3. Run the following commands

```
terraform init
terraform plan
terraform apply
```

### With a local state (Not recommended):
```
terraform init
terraform plan -out "tfplan"
terraform apply "tfplan"
```

Once the infrastructure is deployed, wait 5-10 minutes before trying to access the ELB DNS endpoint (you can find it in the output).
To test the SSH connectivity feel free to gather the private keys using the outputs, e.g. `terraform output bastion_ssh_private_key`

## Acknowledgments
- AWS documentation
- Terraform documentation
