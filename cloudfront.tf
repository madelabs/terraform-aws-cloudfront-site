locals {
  s3_origin_id = "${var.project_name}-primary-s3-origin"
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {}

resource "aws_cloudfront_distribution" "s3_distribution" {
  aliases = ["${var.domain_alias}"]

  origin {
    domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    origin_shield {
      enabled              = var.origin_shield_enabled
      origin_shield_region = var.origin_shield_region
    }

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = var.cloudfront_is_enabled
  is_ipv6_enabled     = var.cloudfront_is_ipv6_enabled
  default_root_object = var.index_document

  default_cache_behavior {
    allowed_methods        = var.cache_behavior_allowed_methods
    cached_methods         = var.cache_behavior_cached_methods
    target_origin_id       = local.s3_origin_id
    viewer_protocol_policy = var.cache_behavior_viewer_protocol_policy
    min_ttl                = var.cache_behavior_min_ttl
    default_ttl            = var.cache_behavior_default_ttl
    max_ttl                = var.cache_behavior_max_ttl

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  dynamic "custom_error_response" {
    for_each = var.custom_error_response
    content {
      error_code            = custom_error_response.value.error_code
      response_page_path    = custom_error_response.value.error_response_page_path
      response_code         = custom_error_response.value.error_response_code
      error_caching_min_ttl = custom_error_response.value.error_caching_min_ttl
    }
  }

  price_class = var.price_class
  web_acl_id  = (var.create_waf && var.apply_waf_cdn) ? aws_wafv2_web_acl.allow_specific_ips_acl[0].arn : null

  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.geo_restriction_locations
    }
  }

  viewer_certificate {
    minimum_protocol_version       = var.ssl_protocol_version
    ssl_support_method             = var.ssl_support_method
    cloudfront_default_certificate = var.cloudfront_default_certificate
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
