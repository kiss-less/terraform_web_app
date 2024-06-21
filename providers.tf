provider "aws" {
  region = "us-east-1"
  alias  = "web_app_dev"

  default_tags {
    tags = {
      "environment"   = "dev"
      "createdBy"     = "terraform"
      "moduleName"    = module.web_app_dev.module_name
      "moduleVersion" = module.web_app_dev.module_version
    }
  }
}
