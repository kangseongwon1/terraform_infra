resource "aws_iam_user" "maxwork-plus-stg-s3" {
  name = "maxwork-plus-stg-s3"
  tags = {
    "user:organization" = "ORG/SL"
  }
}

resource "aws_iam_access_key" "maxwork-plus-stg-s3" {
  user = aws_iam_user.maxwork-plus-stg-s3.name
}


resource "aws_iam_user_policy_attachment" "maxwork-plus-stg-s3-policy" {
  policy_arn = aws_iam_policy.maxwork-plus-stg-s3-policy.arn
  user       = aws_iam_user.maxwork-plus-stg-s3.name
}


