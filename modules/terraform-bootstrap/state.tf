# Inspired by https://github.com/trussworks/terraform-aws-bootstrap

#
# Terraform state bucket
#

module "terraform_state_bucket" {
  source  = "trussworks/s3-private-bucket/aws"
  version = "= 3.7.1"
  enable_bucket_force_destroy = true

  bucket         = local.s3_bucket_name
  logging_bucket = module.terraform_state_bucket_logs.aws_logs_bucket

  use_account_alias_prefix = false

  tags = local.tags
}

#
# Terraform state bucket logging
#

module "terraform_state_bucket_logs" {
  source  = "trussworks/logs/aws"
  version = "= 11.0.0"
  force_destroy = true

  s3_bucket_name          = "${local.s3_bucket_name}-log" # This creates new bucket so name must be unique for logs!
  default_allow           = false
  s3_log_bucket_retention = 30

  logging_target_bucket = "nets-ms-s3-server-access-logs-bucket" #When your source bucket and target bucket are the same, additional logs are created for the logs that are written to the bucket. These extra logs can increase your storage billing and make it harder to find the logs that you're looking for.
  logging_target_prefix = "${local.s3_bucket_name}-log/"
}

# S3 Event notificactions for buckets
resource "aws_s3_bucket_notification" "bucket_notificaction_state" {
  bucket = local.s3_bucket_name
  topic {
    topic_arn     = "arn:aws:sns:eu-central-1:823048641336:S3-EventNotifications" # This is created currently in the ec2-imagebuilder IAC
    events        = ["s3:ObjectRemoved:*","s3:ObjectCreated:*"] # Getting notified about state changes
    filter_suffix = ".tfstate"
  }
}
resource "aws_s3_bucket_notification" "bucket_notificaction_log" {
  bucket = "${local.s3_bucket_name}-log"
  topic {
    topic_arn     = "arn:aws:sns:eu-central-1:823048641336:S3-EventNotifications" # This is created currently in the ec2-imagebuilder IAC
    events        = ["s3:ObjectRemoved:*"] # Permanently deleted, Delete marker created
  }
}


#
# Terraform state locking
#

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-state-lock-${var.project_name}"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"

  server_side_encryption {
    enabled = true
  }

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}
