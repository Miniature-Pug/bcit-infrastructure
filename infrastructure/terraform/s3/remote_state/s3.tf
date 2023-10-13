resource "aws_s3_bucket" "backend" {
  bucket        = "bcit-local"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "backend_ownership" {
  bucket = aws_s3_bucket.backend.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "backend" {
  depends_on = [aws_s3_bucket_ownership_controls.backend_ownership]

  bucket = aws_s3_bucket.backend.id
  acl    = "private"
}


resource "aws_s3_bucket_public_access_block" "backend" {
  bucket = aws_s3_bucket.backend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}