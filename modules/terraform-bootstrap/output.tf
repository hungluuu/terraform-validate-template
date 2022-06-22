output "state_bucket_name" {
  description = "The state_bucket name"
  value       = module.terraform_state_bucket.name
}

output "state_bucket_region" {
  description = "The state_bucket region"
  value       = var.aws_region
}
