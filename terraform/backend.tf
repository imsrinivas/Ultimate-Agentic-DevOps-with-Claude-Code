# S3 backend configuration for remote state management
#
# IMPORTANT: Remote state backend setup
# =====================================
#
# 1. First run: Execute `terraform init` WITHOUT this backend block uncommented
# 2. Run `terraform apply` to provision your resources
# 3. After resources are created, uncomment the backend block below
# 4. Run `terraform init -migrate-state` to migrate state to S3
#
# This two-step approach avoids circular dependencies since the backend bucket
# doesn't exist yet on first initialization.
#
# To enable remote state:
# - Uncomment the terraform block below
# - Ensure the S3 bucket and DynamoDB table exist
# - Run: terraform init -migrate-state

# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-bucket-name"
#     key            = "portfolio-site/terraform.tfstate"
#     region         = "ap-south-1"
#     encrypt        = true
#     dynamodb_table = "terraform-state-lock"
#   }
# }
