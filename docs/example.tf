
module "s3_site" {
  source  = "madelabs/cloudfront-site/aws"
  version = "0.0.3"

  index_document        = "index.html"
  project_name          = "my-project"
  domain_alias          = "my.project.com"
  acm_certificate_arn   = "arn:aws:acm:us-east-1:1234567890123:certificate/123abcde-f345-6789-0123-9abcdefgh01"
  origin_shield_enabled = false
  origin_shield_region  = "us-east-1"
  create_waf            = true
  apply_waf_cdn         = true

  allowed_ips = var.my_list_of_ips

  attach_response_headers_policy = true
  security_headers = {
    content_type_options = {
      override = true
    }
    frame_options = {
      frame_option = "DENY"
      override     = true
    }
    referrer_policy = {
      referrer_policy = "same-origin"
      override        = true
    }
    xss_protection = {
      mode_block = true
      protection = true
      override   = true
    }
    strict_transport_security = {
      access_control_max_age_sec = "63072000"
      include_subdomains         = true
      preload                    = true
      override                   = true
    }
    content_security_policy = {
      content_security_policy = "frame-ancestors 'none'; default-src 'none'; img-src 'self'; script-src 'self'; style-src 'self'; object-src 'none'"
      override                = true
    }
  }
}
