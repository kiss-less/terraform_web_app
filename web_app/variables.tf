variable "environment" {
  type        = string
  description = "Environment. This is useful in case of multiple deployments to the same AWS Account. If deploying multiple times, makes sure to adjust VPC and subnet CIDRs"
}

variable "main_vpc_cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using ipv4_netmask_length."
  default     = "10.1.0.0/16"
}

variable "main_vpc_instance_tenancy" {
  type        = string
  description = "A tenancy option for instances launched into the VPC"
  validation {
    condition     = contains(["default", "dedicated"], var.main_vpc_instance_tenancy)
    error_message = "The only acceptable values are default and dedicated"
  }
  default = "default"
}

variable "public_subnet" {
  type = object({
    cidr = string # CIDR block of the Public subnet
    az   = string # AZ of the Public subnet
  })
  description = "Object defining CIDR block and AZ of the Public subnet"
  default = {
    cidr = "10.1.1.0/24"
    az   = "us-east-1a"
  }
}

variable "frontend_subnet" {
  type = object({
    cidr = string # CIDR block of the Frontend subnet
    az   = string # AZ of the Frontend subnet
  })
  description = "Object defining CIDR block and AZ of the Frontend subnet"
  default = {
    cidr = "10.1.32.0/19"
    az   = "us-east-1b"
  }
}

variable "backend_subnet" {
  type = object({
    cidr = string # CIDR block of the Backend subnet
    az   = string # AZ of the Backend subnet
  })
  description = "Object defining CIDR blocks and AZs of the Backend subnet"
  default = {
    cidr = "10.1.64.0/19"
    az   = "us-east-1c"
  }
}

variable "allowed_ssh_cidrs_list" {
  type        = list(string)
  description = "List of the IPv4 CIDR blocks that are allowed to connect to the VPC instances over SSH."
  default     = ["0.0.0.0/0"] # This needs to be adjusted for the production to restrict everyone from connecting to VPC instances
}

variable "bastion_instance_type" {
  type        = string
  description = "Bastion Host Instance Type"
  default     = "t4g.micro"
}

variable "nat_instance_type" {
  type        = string
  description = "NAT Instance Type"
  default     = "t4g.micro" # Production instance should be bigger. Load tests is the best way to determine the proper size
}

variable "frontend_instance_type" {
  type        = string
  description = "Frontend Host Instance Type"
  default     = "t4g.micro" # Production instance should be bigger and included to the ASG. Load tests is the best way to determine the proper size
}

variable "backend_instance_type" {
  type        = string
  description = "Backend Host Instance Type"
  default     = "t4g.micro" # RDS is a better option for production
}

variable "database_master_password" {
  type        = string
  description = "Password for the master DB user. Make sure to encrypt it in the calling file, e.g. using the sOps terraform provider or similar"
}
