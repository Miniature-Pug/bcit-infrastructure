resource "aws_s3_bucket" "logging" {
  bucket        = "bcit-cloudfront-logging"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "logging_ownership" {
  bucket = aws_s3_bucket.logging.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "logging" {
  depends_on = [aws_s3_bucket_ownership_controls.logging_ownership]

  bucket = aws_s3_bucket.logging.id
  acl    = "private"
}


resource "aws_s3_bucket_public_access_block" "logging" {
  bucket = aws_s3_bucket.logging.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "logging" {
  bucket = aws_s3_bucket.logging.id

  rule {
    id = "expire"

    expiration {
      days = 1
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "logging" {
  bucket = aws_s3_bucket.logging.id
  policy = data.aws_iam_policy_document.logging.json
}

data "aws_iam_policy_document" "logging" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::127311923021:root"]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      aws_s3_bucket.logging.arn,
      "${aws_s3_bucket.logging.arn}/*",
    ]
  }
}