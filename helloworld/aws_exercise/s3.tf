resource "aws_s3_bucket" "s3statebucket" {
  lifecycle {
    prevent_destroy = false
  }
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "s3statebucket" {
  bucket = aws_s3_bucket.s3statebucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3statebucket" {
  bucket = aws_s3_bucket.s3statebucket.id
  rule {
      apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
      }

  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.s3statebucket.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}


