output "bastion_ssh_private_key" {
  value     = module.web_app_dev.bastion_ssh.private_key_openssh
  sensitive = true
}

output "nat_ssh_private_key" {
  value     = module.web_app_dev.nat_ssh.private_key_openssh
  sensitive = true
}

output "frontend_ssh_private_key" {
  value     = module.web_app_dev.frontend_ssh.private_key_openssh
  sensitive = true
}

output "backend_ssh_private_key" {
  value     = module.web_app_dev.backend_ssh.private_key_openssh
  sensitive = true
}

output "elb_dns_http" {
  value = "http://${module.web_app_dev.elb_dns}"
}
