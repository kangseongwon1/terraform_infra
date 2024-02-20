output "aws_iam_user" {
  description = "The user's name"
  value = aws_iam_user.maxwork-plus-stg-s3.name
}

output "iam_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = aws_iam_user.maxwork-plus-stg-s3
}

output "iam_instance_profile" {
  value = aws_iam_instance_profile.ssm_manager.name
}

output "iam_access_key_id" {
  description = "The access key ID"
  value       = aws_iam_access_key.maxwork-plus-stg-s3.id
}


output "iam_access_key_secret" {
  description = "The access key secret"
  value       = aws_iam_access_key.maxwork-plus-stg-s3.encrypted_secret
  sensitive   = true
}


output "maxwork-plus-stg-s3-policy" {
    description = "maxwork-plus-stg-s3-policy"
    value = data.aws_iam_policy_document.maxwork-plus-stg-s3-policy.json
}