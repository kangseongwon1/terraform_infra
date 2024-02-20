#######################################
## Identity and Access Management policy (IAM)



data "aws_iam_policy_document" "maxwork-plus-stg-s3-policy" {
    statement {
      actions = [
        "s3:ListAllMyBuckets",
        "s3:GetBucketLocation",
        ]
        resources = [
        "arn:aws:s3:::*",
        ]
    }

    statement {
      actions = [
        "s3:ListBucket",
      ]
      resources = [
        "arn:aws:s3:::maxwork-stg-s3-policy"
      ]
    }

    statement {
      actions = [
        "s3:GetObject",
        "s3:PutObject"
      ]
      resources = [
        "arn:aws:s3:::maxwork-stg-s3-policy",
        "arn:aws:s3:::maxwork-stg-s3-policy/*"
      ]
    }
}

# IAM 정책 생성
resource "aws_iam_policy" "maxwork-plus-stg-s3-policy" {
  name        = "maxwork-plus-stg-s3-policy"
  description = "IAM policy for S3 access"
  
  policy = data.aws_iam_policy_document.maxwork-plus-stg-s3-policy.json
}
