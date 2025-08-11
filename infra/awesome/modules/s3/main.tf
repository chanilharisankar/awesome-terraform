# Generate a random suffix for bucket name
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Create S3 bucket
resource "aws_s3_bucket" "main" {
  bucket = "${var.project_name}-${var.environment}-bucket-${random_string.bucket_suffix.result}"

  tags = {
    Name = "${var.project_name}-${var.environment}-bucket"
  }
}

# Configure bucket versioning
resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Configure bucket encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
