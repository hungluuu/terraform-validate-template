# Terraform state storage bootstrap

This bootstrap code solves the chicken-n-egg problem with Terraform state storage.
This Terraform code creates a bucket for the Terraform state and stores it own state
locally in version control.

**THIS DIRECTORY NEVER SHOULD INCLUDE ANYTHING CONFIDENTAL!**

## Including terraform-bootstrap to your project
Go to the folder that has your Terraform IAC

```bash
git submodule add git@github.com:Nets-Platform-Enablement/terraform-bootstrap.git
```

## Setup terraform state storage

```bash
cd terraform-bootstrap
terraform init
terraform plan -out bootstrap.tfplan
terraform apply bootstrap.tfplan
```

Note the `state_bucket_name` from the output, use that in your projects `remote.tf`:

```markdown
terraform {
  backend "s3" {
    # These are values from the bootstrap Terraform code
    # Consider using Terragrunt to avoid duplicating these values
    profile = "{aws_profile}"
    bucket  = "{state_bucket_name}"
    key     = "mstms/service-terraform.tfstate"
    region  = "{aws_region}"
  }
}
```