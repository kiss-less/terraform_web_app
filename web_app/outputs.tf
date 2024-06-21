output "module_name" {
  value = "web_app"
}

# This is useful to be able to visualize used module versions in AWS Accounts. Such an approach helps to better observe the technical dept
# The version in this var, CHANGELOG and VERSION file should be automatically changed by CI (e.g. based on git tags)
output "module_version" {
  value = "1.0.0"
}

output "vpc" {
  value = aws_vpc.this
}

output "public_subnet" {
  value = aws_subnet.public
}

output "private_backend_subnet" {
  value = aws_subnet.private_backend
}

output "private_frontend_subnet" {
  value = aws_subnet.private_frontend
}

output "bastion_ssh" {
  value     = tls_private_key.bastion
  sensitive = true
}

output "nat_ssh" {
  value     = tls_private_key.nat
  sensitive = true
}

output "frontend_ssh" {
  value     = tls_private_key.frontend
  sensitive = true
}

output "backend_ssh" {
  value     = tls_private_key.backend
  sensitive = true
}

output "elb_dns" {
  value = aws_elb.elb.dns_name
}