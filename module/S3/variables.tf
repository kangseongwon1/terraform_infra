variable "create_bucket" {
  type = bool
  default = true
}

variable "attach_policy" {
  type = bool
  default = false
}

variable "bucket" {
  
}

variable "tags" {
  
}

variable "policy" {
  description = "(Optional) A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  type        = string
  default     = null
}

variable "versioning" {
  
}

# variable "expected_bucket_owner" {
  
# }

variable "cors_rule" {
  
}