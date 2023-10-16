locals {
  s3_origin_id = "${var.project_name}-primary-s3-origin"
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {}

resource "aws_cloudfront_distribution" "s3_distribution" {
  aliases = ["${var.domain_alias}"]

  origin {
    domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    dynamic "origin_shield" {
      for_each = var.origin_shield_enabled ? [1] : []
      content {
        enabled              = true
        origin_shield_region = var.origin_shield_region
      }
    }

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = var.cloudfront_is_enabled
  is_ipv6_enabled     = var.cloudfront_is_ipv6_enabled
  default_root_object = var.index_document

  default_cache_behavior {
    allowed_methods            = var.cache_behavior_allowed_methods
    cached_methods             = var.cache_behavior_cached_methods
    target_origin_id           = local.s3_origin_id
    viewer_protocol_policy     = var.cache_behavior_viewer_protocol_policy
    min_ttl                    = var.cache_behavior_min_ttl
    default_ttl                = var.cache_behavior_default_ttl
    max_ttl                    = var.cache_behavior_max_ttl
    response_headers_policy_id = var.attach_response_headers_policy ? aws_cloudfront_response_headers_policy.policy.id : null
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


resource "aws_cloudfront_response_headers_policy" "policy" {
  name = "${var.project_name}-header-policy"

  security_headers_config {

    dynamic "content_type_options" {
      for_each = var.security_headers.content_type_options == null ? [] : [var.security_headers.content_type_options]
      content {
        override = lookup(content_type_options.value, "override", null)
      }
    }

    dynamic "frame_options" {
      for_each = var.security_headers.frame_options == null ? [] : [var.security_headers.frame_options]
      content {
        frame_option = lookup(frame_options.value, "frame_option", null)
        override     = lookup(frame_options.value, "override", null)
      }
    }

    dynamic "referrer_policy" {
      for_each = var.security_headers.referrer_policy == null ? [] : [var.security_headers.referrer_policy]
      content {
        referrer_policy = lookup(referrer_policy.value, "referrer_policy", null)
        override        = lookup(referrer_policy.value, "override", null)
      }
    }

    dynamic "xss_protection" {
      for_each = var.security_headers.xss_protection == null ? [] : [var.security_headers.xss_protection]
      content {
        mode_block = lookup(xss_protection.value, "mode_block", null)
        protection = lookup(xss_protection.value, "protection", null)
        override   = lookup(xss_protection.value, "override", null)
      }
    }

    dynamic "strict_transport_security" {
      for_each = var.security_headers.strict_transport_security == null ? [] : [var.security_headers.strict_transport_security]
      content {
        access_control_max_age_sec = lookup(strict_transport_security.value, "access_control_max_age_sec", null)
        include_subdomains         = lookup(strict_transport_security.value, "include_subdomains", null)
        preload                    = lookup(strict_transport_security.value, "preload", null)
        override                   = lookup(strict_transport_security.value, "override", null)
      }
    }

    dynamic "content_security_policy" {
      for_each = var.security_headers.content_security_policy == null ? [] : [var.security_headers.content_security_policy]
      content {
        content_security_policy = lookup(content_security_policy.value, "content_security_policy", null)
        override                = lookup(content_security_policy.value, "override", null)
      }
    }

  }
}


