# web_app

Author: https://github.com/kiss-less

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.8.5 |
| aws | >= 5.54.1 |
| tls | >= 4.0.5 |

## Resources

| Name | Type |
|------|------|
| [aws_elb.elb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elb) | resource |
| [aws_instance.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_key_pair.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_key_pair.frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_key_pair.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private_frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.elb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.backend_inbound_3306_frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.backend_inbound_ssh_bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.backend_outbound_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.backend_outbound_http_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.backend_outbound_https_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.bastion_inbound_ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.bastion_outbound_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.bastion_outbound_backend_ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.bastion_outbound_frontend_ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.bastion_outbound_nat_ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.elb_inbound_http_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.elb_inbound_https_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.elb_outbound_8080_frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.frontend_inbound_8080_elb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.frontend_inbound_ssh_bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.frontend_outbound_3306_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.frontend_outbound_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.frontend_outbound_http_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.frontend_outbound_https_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nat_inbound_http_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nat_inbound_http_frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nat_inbound_https_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nat_inbound_https_frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nat_inbound_ssh_bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nat_outbound_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.private_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private_frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [tls_private_key.backend](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.bastion](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.frontend](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.nat](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| database\_master\_password | Password for the master DB user. Make sure to encrypt it in the calling file, e.g. using the sOps terraform provider or similar | `string` | n/a | yes |
| environment | Environment. This is useful in case of multiple deployments to the same AWS Account. If deploying multiple times, makes sure to adjust VPC and subnet CIDRs | `string` | n/a | yes |
| allowed\_ssh\_cidrs\_list | List of the IPv4 CIDR blocks that are allowed to connect to the VPC instances over SSH. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| backend\_instance\_type | Backend Host Instance Type | `string` | `"t4g.micro"` | no |
| backend\_subnet | Object defining CIDR blocks and AZs of the Backend subnet | <pre>object({<br>    cidr = string # CIDR block of the Backend subnet<br>    az   = string # AZ of the Backend subnet<br>  })</pre> | <pre>{<br>  "az": "us-east-1c",<br>  "cidr": "10.1.64.0/19"<br>}</pre> | no |
| bastion\_instance\_type | Bastion Host Instance Type | `string` | `"t4g.micro"` | no |
| frontend\_instance\_type | Frontend Host Instance Type | `string` | `"t4g.micro"` | no |
| frontend\_subnet | Object defining CIDR block and AZ of the Frontend subnet | <pre>object({<br>    cidr = string # CIDR block of the Frontend subnet<br>    az   = string # AZ of the Frontend subnet<br>  })</pre> | <pre>{<br>  "az": "us-east-1b",<br>  "cidr": "10.1.32.0/19"<br>}</pre> | no |
| main\_vpc\_cidr\_block | The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using ipv4\_netmask\_length. | `string` | `"10.1.0.0/16"` | no |
| main\_vpc\_instance\_tenancy | A tenancy option for instances launched into the VPC | `string` | `"default"` | no |
| nat\_instance\_type | NAT Instance Type | `string` | `"t4g.micro"` | no |
| public\_subnet | Object defining CIDR block and AZ of the Public subnet | <pre>object({<br>    cidr = string # CIDR block of the Public subnet<br>    az   = string # AZ of the Public subnet<br>  })</pre> | <pre>{<br>  "az": "us-east-1a",<br>  "cidr": "10.1.1.0/24"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| backend\_ssh | n/a |
| bastion\_ssh | n/a |
| elb\_dns | n/a |
| frontend\_ssh | n/a |
| module\_name | n/a |
| module\_version | This is useful to be able to visualize used module versions in AWS Accounts. Such an approach helps to better observe the technical dept The version in this var, CHANGELOG and VERSION file should be automatically changed by CI (e.g. based on git tags) |
| nat\_ssh | n/a |
| private\_backend\_subnet | n/a |
| private\_frontend\_subnet | n/a |
| public\_subnet | n/a |
| vpc | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
