resource "aws_s3_bucket" "east_website_bucket" {
  bucket        = "e1-${var.project_name}"
  force_destroy = var.force_destroy

  tags = {
    project = var.project_name
  }
}

data "aws_iam_policy_document" "east_bucket_policy" {

  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.east_website_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "east_bucket_read_policy" {
  bucket = aws_s3_bucket.east_website_bucket.id
  policy = data.aws_iam_policy_document.east_bucket_policy.json
}

resource "aws_s3_bucket" "cloudfront_logging" {
  bucket        = "e1-cloudfront-${var.project_name}-logging"
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_acl" "cloudfront_logging_bucket_acl" {
  bucket = aws_s3_bucket.cloudfront_logging.id
  acl    = "log-delivery-write"
}
