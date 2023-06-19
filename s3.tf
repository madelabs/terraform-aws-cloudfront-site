resource "aws_s3_bucket" "website_bucket" {
  bucket        = var.project_name
  force_destroy = var.force_destroy

  tags = {
    project = var.project_name
  }
}

data "aws_iam_policy_document" "bucket_policy" {

  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.website_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_read_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

resource "aws_s3_bucket" "cloudfront_logging" {
  bucket        = "${var.project_name}-cloudfront-logging"
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_acl" "cloudfront_logging_bucket_acl" {
  bucket = aws_s3_bucket.cloudfront_logging.id
  acl    = "log-delivery-write"
}


resource "aws_s3_bucket_ownership_controls" "logging_ownership" {
  bucket = aws_s3_bucket.cloudfront_logging.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
