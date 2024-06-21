# The terraform state should be stored remotely e.g. in the s3 bucket, which should be created in advance.
# This should be done to increase security (e.g. SSH keys will be stored there) and avoid issues with inconsistency 
# of the resources mentioned in the state, for example when multiple people work with it at the same time. 
# If you'd like to proceed with it, please create the s3 bucket, make sure its name and region are specified 
# below and uncomment the configuration

# terraform {
#   backend "s3" {
#     bucket = "bucket-to-store-web-app-dev-tf-state"
#     key    = "web_app_dev.tfstate"
#     region = "us-east-1"
#   }
# }
