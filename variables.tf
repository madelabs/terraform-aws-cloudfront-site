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
  default     = true
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
}

variable "blacklist" {
  type        = list(string)
  description = "The ISO 3166-1-alpha-2 codes for which you want CloudFront to not distribute your content (blacklist)"
  default     = ["RU", "KP", "IR"]
}

variable "price_class" {
  type        = string
  description = "The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100."
  default     = "PriceClass_100"
}

variable "min_ttl" {
  type        = number
  description = "The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds"
  default     = 0
}

variable "default_ttl" {
  type        = number
  description = "The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header"
  default     = 60
}

variable "max_ttl" {
  type        = number
  description = "The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated."
  default     = 120
}

variable "domain_alias" {
  type        = string
  description = "The domain alias to apply to your distribution. Example: mydomain.domain.com"
}

variable "acm_certificate_arn" {
  type        = string
  description = "The arn for the ACM certificate to be used with the domain_alias."
}

variable "ssl_protocol_version" {
  type        = string
  description = "Minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections."
  default     = "TLSv1.2_2021"
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
  description = "Enable or disable the creation of WAFv2 Web ACL resources."
  type        = bool
  default     = false
}

variable "apply_waf_cdn" {
  description = "Wether or not to enable the restriction of IP addresses."
  type        = bool
  default     = false
}
