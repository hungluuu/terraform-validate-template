variable "repository_name" {
  default     = "tf-validate"
  description = "CodeCommit repository name for CodePipeline builds"
}

variable "listen_branch_name" {
  default     = "main"
  description = "CodeCommit branch name for CodePipeline builds"
}

variable "codestar_connection_arn" {
  default     = "arn:aws:codestar-connections:eu-central-1:942676077303:connection/8b411ccd-11cb-4494-9b22-5368ae568a6a"
  description = "Add Code Star Connection created from AWS Developer Tools to Github"
}
