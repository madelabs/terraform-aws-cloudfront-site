resource "aws_wafv2_ip_set" "allowed_ipset" {
  count              = var.create_waf ? 1 : 0
  name               = "${var.project_name}-allowed-ipset"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"

  addresses = var.allowed_ips
}

resource "aws_wafv2_web_acl" "allow_specific_ips_acl" {
  count = var.create_waf ? 1 : 0
  name  = "${var.project_name}-acl"
  scope = "CLOUDFRONT"

  default_action {
    block {}
  }

  rule {
    name     = "${var.project_name}-allow-only-specific-ips"
    priority = 1

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.allowed_ipset[0].arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = var.allowed_traffic_cloudwatch_metrics_enabled
      metric_name                = "${var.project_name}-allowed-traffic"
      sampled_requests_enabled   = var.allowed_traffic_sampled_requests_enabled
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.blocked_traffic_cloudwatch_metrics_enabled
    metric_name                = "${var.project_name}-blocked-traffic"
    sampled_requests_enabled   = var.blocked_traffic_sampled_requests_enabled
  }
}
