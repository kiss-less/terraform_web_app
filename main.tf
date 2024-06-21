# In real-world scenario modules should be put into some remote source (e.g. s3 bucket, ideally by CI) 
# and referenced as source = "s3::https://s3.amazonaws.com/<BUCKET_NAME>/<SUBDIR>/<MODULE_NAME>-<MODULE_VERSION>.zip"
# However, for the sake of simplicity I'm going to call the modules from their subdirs

module "web_app_dev" {
  source      = "./web_app"
  environment = "dev"

  # The below var should not be stored in the plaintext. It should be encrypted with AWS KMS using the terraform sOps provider
  # https://registry.terraform.io/providers/carlpett/sops/latest/docs#example-usage or some similar solution.
  # The sops file should be created in advance before deploying the solution, which complicates the deployment process.
  # Therefore, for the simplicity reason I'm going to keep it as a plaintext.
  # However, I'm more than happy to showcase the sOps solution if needed.
  database_master_password = "V3rySeCu9ePaSSw0rD"

  providers = {
    aws = aws.web_app_dev
  }
}
