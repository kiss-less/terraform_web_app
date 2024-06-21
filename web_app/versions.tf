terraform {
  required_version = ">=1.8.5"

  # https://developer.hashicorp.com/terraform/language/modules/develop/providers#provider-version-constraints-in-modules
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.54.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.5"
    }
  }
}
