locals {
  s3_origin_id = "${var.project_name}-primarys3Origin"
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {}

resource "aws_cloudfront_distribution" "s3_distribution" {
  aliases = ["${var.domain_alias}"]

  origin {
    domain_name = aws_s3_bucket.east_website_bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    origin_shield {
      enabled              = true
      origin_shield_region = "us-east-1"
    }

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.index_document

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  custom_error_response {
    error_code         = 403
    response_page_path = "/index.html"
    response_code      = 403
  }


  price_class = var.price_class
  web_acl_id  = (var.create_waf && var.apply_waf_cdn) ? aws_wafv2_web_acl.allow_specific_ips_acl[0].arn : null

  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = var.blacklist
    }
  }

  viewer_certificate {
    minimum_protocol_version       = var.ssl_protocol_version
    ssl_support_method             = "sni-only"
    cloudfront_default_certificate = true
    acm_certificate_arn            = var.acm_certificate_arn
  }

  logging_config {
    bucket = aws_s3_bucket.cloudfront_logging.bucket_domain_name
    prefix = local.s3_origin_id
  }

  tags = {
    Terraformed = "true"
    Project     = var.project_name
  }
}
