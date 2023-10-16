variable "index_document" {
  type        = string
  default     = "index.html"
  description = "The default file that CloudFront will look for."
}

variable "project_name" {
  type        = string
  description = "The project name."
}

variable "force_destroy" {
  type        = bool
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = true
}

variable "price_class" {
  type        = string
  description = "The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100."
  default     = "PriceClass_100"

  validation {
    condition     = can(regex("^(PriceClass_All|PriceClass_200|PriceClass_100)$", var.price_class))
    error_message = "price_class must be one of PriceClass_All, PriceClass_200, PriceClass_100"
  }
}

variable "domain_alias" {
  type        = string
  description = "The domain alias to apply to your distribution. Example: mydomain.domain.com"
}

variable "acm_certificate_arn" {
  type        = string
  description = "The arn for the ACM certificate to be used with the domain_alias."
}

variable "cloudfront_default_certificate" {
  type        = bool
  description = "Whether or not to use the default CloudFront certificate. If false, you must specify the acm_certificate_arn."
  default     = false
}

variable "ssl_protocol_version" {
  type        = string
  description = "Minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections."
  default     = "TLSv1.2_2021"

  validation {
    condition     = can(regex("^(SSLv3|TLSv1|TLSv1.1|TLSv1.2|TLSv1.2_2018|TLSv1.2_2019|TLSv1.2_2021)$", var.ssl_protocol_version))
    error_message = "ssl_protocol_version must be one of SSLv3, TLSv1, TLSv1.1, TLSv1.2, TLSv1.2_2018, TLSv1.2_2019, TLSv1.2_2021"
  }
}

variable "ssl_support_method" {
  type        = string
  description = "How you want CloudFront to serve HTTPS requests. One of vip or sni-only."
  default     = "sni-only"

  validation {
    condition     = can(regex("^(vip|sni-only)$", var.ssl_support_method))
    error_message = "ssl_support_method must be one of vip or sni-only"
  }
}

variable "allowed_ips" {
  type        = list(string)
  description = "The list of IP addresses to allow access to the cloudfront distribution"
  default     = []
}

variable "allowed_traffic_cloudwatch_metrics_enabled" {
  type        = bool
  description = "Whether or not to enable the metrics for the allowed traffic rule."
  default     = true
}

variable "blocked_traffic_cloudwatch_metrics_enabled" {
  type        = bool
  description = "Whether or not to enable the metrics for the blocked traffic rule."
  default     = true
}

variable "allowed_traffic_sampled_requests_enabled" {
  type        = bool
  description = "Whether or not to enable the sampled requests (3hr) for the allowed traffic rule."
  default     = true
}

variable "blocked_traffic_sampled_requests_enabled" {
  type        = bool
  description = "Whether or not to enable the sampled requests (3hr) for the blocked traffic rule."
  default     = true
}

variable "create_waf" {
  type        = bool
  description = "Enable or disable the creation of WAFv2 Web ACL resources."
  default     = false
}

variable "apply_waf_cdn" {
  type        = bool
  description = "Wether or not to enable the restriction of IP addresses."
  default     = false
}

variable "cloudfront_is_ipv6_enabled" {
  type        = bool
  description = "Whether or not to enable IPv6 for the CloudFront distribution."
  default     = true
}

variable "cloudfront_is_enabled" {
  type        = bool
  description = "Whether or not to enable the CloudFront distribution."
  default     = true
}

variable "cache_behavior_allowed_methods" {
  type        = list(string)
  description = "Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin."
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cache_behavior_cached_methods" {
  type        = list(string)
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods."
  default     = ["GET", "HEAD"]
}

variable "cache_behavior_viewer_protocol_policy" {
  type        = string
  description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https."
  default     = "redirect-to-https"

  validation {
    condition     = can(regex("^(allow-all|https-only|redirect-to-https)$", var.cache_behavior_viewer_protocol_policy))
    error_message = "cache_behavior_viewer_protocol_policy must be one of allow-all, https-only, or redirect-to-https"
  }
}

variable "cache_behavior_min_ttl" {
  type        = number
  description = "The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds"
  default     = 0
}

variable "cache_behavior_default_ttl" {
  type        = number
  description = "The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header"
  default     = 60
}

variable "cache_behavior_max_ttl" {
  type        = number
  description = "The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated."
  default     = 120
}

variable "geo_restriction_type" {
  type        = string
  description = "Method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist."
  default     = "blacklist"

  validation {
    condition     = can(regex("^(none|whitelist|blacklist)$", var.geo_restriction_type))
    error_message = "geo_restriction_type must be one of none, whitelist, or blacklist"
  }
}

variable "geo_restriction_locations" {
  type        = list(string)
  description = "The ISO 3166-1-alpha-2 codes for which you want CloudFront to not distribute your content (blacklist)"
  default     = ["RU", "KP", "IR"]

  validation {
    condition     = alltrue([for loc in var.geo_restriction_locations : can(regex("^[A-Z]{2}$", loc))])
    error_message = "Each element of geo_restriction_locations must be an ISO 3166-1-alpha-2 code. Lookup codes here https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2"
  }
}

variable "origin_shield_enabled" {
  type        = bool
  description = "Whether Origin Shield is enabled."
  default     = false
}

variable "origin_shield_region" {
  type        = string
  description = "AWS Region for Origin Shield. To specify a region, use the region code, not the region name. For example, specify the US East (Ohio) region as us-east-2. Based on https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/origin-shield.html#choose-origin-shield-region"
  default     = "us-east-1"

  validation {
    condition     = can(regex("^(us-east-2|us-east-1|us-west-2|ap-south-1|ap-northeast-2|ap-southeast-1|ap-southeast-2|ap-northeast-1|eu-central-1|eu-west-1|eu-west-2|sa-east-1)$", var.origin_shield_region))
    error_message = "origin_shield_region must be one of us-east-2, us-east-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, eu-central-1, eu-west-1, eu-west-2, sa-east-1"
  }
}

variable "custom_error_response" {
  type = list(object({
    error_code               = number
    error_response_code      = optional(number)
    error_response_page_path = optional(string)
    error_caching_min_ttl    = optional(string)
  }))
  default = [{
    error_code               = 403
    error_response_code      = 403
    error_response_page_path = "/index.html"
  }]
  description = "Custom Error Response Arguments"
}

variable "security_headers" {
  type = object({
    content_type_options      = optional(map(any))
    frame_options             = optional(map(any))
    referrer_policy           = optional(map(any))
    xss_protection            = optional(map(any))
    strict_transport_security = optional(map(any))
    content_security_policy   = optional(map(any))
  })
  default = {}
}

variable "attach_response_headers_policy" {
  type        = bool
  description = "Whether or not to create a response headers policy."
  default     = false
}
