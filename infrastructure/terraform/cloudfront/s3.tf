locals {
  policy_parameters = {
    bucket_arn = aws_s3_bucket.cloudfront.arn
    user_arn   = aws_cloudfront_origin_access_identity.static.iam_arn
  }
}

resource "aws_s3_bucket" "cloudfront" {
  bucket        = "bcit-cloudfront"
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "cloudfront" {
  bucket = aws_s3_bucket.cloudfront.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "cloudfront_ownership" {
  bucket = aws_s3_bucket.cloudfront.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "cloudfront" {
  depends_on = [aws_s3_bucket_ownership_controls.cloudfront_ownership]

  bucket = aws_s3_bucket.cloudfront.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "cloudfront" {
  bucket     = aws_s3_bucket.cloudfront.id
  policy     = templatefile("${path.module}/policies/s3_bucket_policy.tpl.json", local.policy_parameters)
  depends_on = [aws_cloudfront_origin_access_identity.static]
}

resource "aws_s3_bucket_public_access_block" "cloudfront" {
  bucket = aws_s3_bucket.cloudfront.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "static_files" {
  bucket       = aws_s3_bucket.cloudfront.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
  etag         = filemd5("index.html")
}

data "aws_s3_bucket" "logging" {
  bucket = "bcit-cloudfront-logging"
}

resource "aws_s3_bucket_cors_configuration" "cloudfront" {
  bucket = aws_s3_bucket.cloudfront.id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
  }
}
