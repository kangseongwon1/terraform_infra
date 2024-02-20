#######################################
## Identity and Access Management (IAM)

# IAM role
resource "aws_iam_role" "ssm_manager" {
  name = "ssm_manager"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Attaches a Managed IAM Policy to an IAM role
resource "aws_iam_role_policy_attachment" "maxwork-plus-stg-s3" {
  role       = aws_iam_role.ssm_manager.name
  policy_arn = aws_iam_policy.maxwork-plus-stg-s3-policy.arn
}

resource "aws_iam_role_policy_attachment" "private_for_ssm" {
  role       = aws_iam_role.ssm_manager.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# IAM instance profile
resource "aws_iam_instance_profile" "ssm_manager" {
  name = "ssm_manager"
  role = aws_iam_role.ssm_manager.name
}