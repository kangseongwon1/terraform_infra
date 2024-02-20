locals {
  create_bucket = var.create_bucket
  attach_policy = var.attach_policy

  cors_rules           = try(jsondecode(var.cors_rule), var.cors_rule)
}

resource "aws_s3_bucket" "this" {
  count = local.create_bucket ? 1 : 0
  bucket = var.bucket
  tags = var.tags
}


resource "aws_s3_bucket_public_access_block" "this" {
  count = local.attach_policy ? 1 : 0

  bucket = aws_s3_bucket.this[0].id
}

resource "aws_s3_bucket_policy" "this" {
  count  = length(data.aws_iam_policy_document.combined) > 0 ? 1 : 0
  
  bucket = aws_s3_bucket.this[0].id
  policy = data.aws_iam_policy_document.combined[0].json

  depends_on = [ 
    aws_s3_bucket_public_access_block.this
   ]
}

data "aws_iam_policy_document" "combined" { 
  count = local.create_bucket && local.attach_policy ? 1: 0

  source_policy_documents = compact([
    var.attach_policy ? var.policy : ""
  ])
}

resource "aws_s3_bucket_versioning" "this" {
  count = local.create_bucket && length(keys(var.versioning)) > 0 ? 1 : 0

  bucket                = aws_s3_bucket.this[0].id
#   expected_bucket_owner = var.expected_bucket_owner
  mfa                   = try(var.versioning["mfa"], null)

  versioning_configuration {
    # Valid values: "Enabled" or "Suspended"
    status = try(var.versioning["enabled"] ? "Enabled" : "Suspended", tobool(var.versioning["status"]) ? "Enabled" : "Suspended", title(lower(var.versioning["status"])))

    # Valid values: "Enabled" or "Disabled"
    mfa_delete = try(tobool(var.versioning["mfa_delete"]) ? "Enabled" : "Disabled", title(lower(var.versioning["mfa_delete"])), null)
  }
}

resource "aws_s3_bucket_cors_configuration" "this" {
  count = local.create_bucket && length(local.cors_rules) > 0 ? 1 : 0

  bucket                = aws_s3_bucket.this[0].id
  # expected_bucket_owner = var.expected_bucket_owner

  dynamic "cors_rule" {
    for_each = local.cors_rules

    content {
      id              = try(cors_rule.value.id, null)
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      allowed_headers = try(cors_rule.value.allowed_headers, null)
      expose_headers  = try(cors_rule.value.expose_headers, null)
      max_age_seconds = try(cors_rule.value.max_age_seconds, null)
    }
  }
}
