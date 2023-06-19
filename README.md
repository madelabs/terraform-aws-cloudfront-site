# terraform-aws-cloudfront-site

<!-- BEGIN MadeLabs Header -->
![MadeLabs is for hire!](https://d2xqy67kmqxrk1.cloudfront.net/horizontal_logo_white.png)
MadeLabs is proud to support the open source community with these blueprints for provisioning infrastructure to help software builders get started quickly and with confidence. 

We're also for hire: [https://www.madelabs.io](https://www.madelabs.io)
<!-- END MadeLabs Header -->

A Terraform module for managing a S3 hosted web application that is behind CloudFront CDN.

## Requirements

- ACM Certificate ARN

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.s3_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.origin_access_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_s3_bucket.cloudfront_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.website_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.cloudfront_logging_bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_ownership_controls.logging_ownership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.bucket_read_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_wafv2_ip_set.allowed_ipset](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_ip_set) | resource |
| [aws_wafv2_web_acl.allow_specific_ips_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | The arn for the ACM certificate to be used with the domain\_alias. | `string` | n/a | yes |
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | The list of IP addresses to allow access to the cloudfront distribution | `list(string)` | `[]` | no |
| <a name="input_allowed_traffic_cloudwatch_metrics_enabled"></a> [allowed\_traffic\_cloudwatch\_metrics\_enabled](#input\_allowed\_traffic\_cloudwatch\_metrics\_enabled) | Whether or not to enable the metrics for the allowed traffic rule. | `bool` | `true` | no |
| <a name="input_allowed_traffic_sampled_requests_enabled"></a> [allowed\_traffic\_sampled\_requests\_enabled](#input\_allowed\_traffic\_sampled\_requests\_enabled) | Whether or not to enable the sampled requests (3hr) for the allowed traffic rule. | `bool` | `true` | no |
| <a name="input_apply_waf_cdn"></a> [apply\_waf\_cdn](#input\_apply\_waf\_cdn) | Wether or not to enable the restriction of IP addresses. | `bool` | `false` | no |
| <a name="input_blocked_traffic_cloudwatch_metrics_enabled"></a> [blocked\_traffic\_cloudwatch\_metrics\_enabled](#input\_blocked\_traffic\_cloudwatch\_metrics\_enabled) | Whether or not to enable the metrics for the blocked traffic rule. | `bool` | `true` | no |
| <a name="input_blocked_traffic_sampled_requests_enabled"></a> [blocked\_traffic\_sampled\_requests\_enabled](#input\_blocked\_traffic\_sampled\_requests\_enabled) | Whether or not to enable the sampled requests (3hr) for the blocked traffic rule. | `bool` | `true` | no |
| <a name="input_cache_behavior_allowed_methods"></a> [cache\_behavior\_allowed\_methods](#input\_cache\_behavior\_allowed\_methods) | Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin. | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD",<br>  "OPTIONS"<br>]</pre> | no |
| <a name="input_cache_behavior_cached_methods"></a> [cache\_behavior\_cached\_methods](#input\_cache\_behavior\_cached\_methods) | Controls whether CloudFront caches the response to requests using the specified HTTP methods. | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD"<br>]</pre> | no |
| <a name="input_cache_behavior_default_ttl"></a> [cache\_behavior\_default\_ttl](#input\_cache\_behavior\_default\_ttl) | The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header | `number` | `60` | no |
| <a name="input_cache_behavior_max_ttl"></a> [cache\_behavior\_max\_ttl](#input\_cache\_behavior\_max\_ttl) | The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. | `number` | `120` | no |
| <a name="input_cache_behavior_min_ttl"></a> [cache\_behavior\_min\_ttl](#input\_cache\_behavior\_min\_ttl) | The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds | `number` | `0` | no |
| <a name="input_cache_behavior_viewer_protocol_policy"></a> [cache\_behavior\_viewer\_protocol\_policy](#input\_cache\_behavior\_viewer\_protocol\_policy) | Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https. | `string` | `"redirect-to-https"` | no |
| <a name="input_cloudfront_default_certificate"></a> [cloudfront\_default\_certificate](#input\_cloudfront\_default\_certificate) | Whether or not to use the default CloudFront certificate. If false, you must specify the acm\_certificate\_arn. | `bool` | `true` | no |
| <a name="input_cloudfront_is_enabled"></a> [cloudfront\_is\_enabled](#input\_cloudfront\_is\_enabled) | Whether or not to enable the CloudFront distribution. | `bool` | `true` | no |
| <a name="input_cloudfront_is_ipv6_enabled"></a> [cloudfront\_is\_ipv6\_enabled](#input\_cloudfront\_is\_ipv6\_enabled) | Whether or not to enable IPv6 for the CloudFront distribution. | `bool` | `true` | no |
| <a name="input_create_waf"></a> [create\_waf](#input\_create\_waf) | Enable or disable the creation of WAFv2 Web ACL resources. | `bool` | `false` | no |
| <a name="input_custom_error_response"></a> [custom\_error\_response](#input\_custom\_error\_response) | Custom Error Response Arguments | <pre>list(object({<br>    error_code               = number<br>    error_response_code      = optional(number)<br>    error_response_page_path = optional(string)<br>    error_caching_min_ttl    = optional(string)<br>  }))</pre> | <pre>[<br>  {<br>    "error_code": 403,<br>    "error_response_code": 403,<br>    "error_response_page_path": "/index.html"<br>  }<br>]</pre> | no |
| <a name="input_domain_alias"></a> [domain\_alias](#input\_domain\_alias) | The domain alias to apply to your distribution. Example: mydomain.domain.com | `string` | n/a | yes |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `true` | no |
| <a name="input_geo_restriction_locations"></a> [geo\_restriction\_locations](#input\_geo\_restriction\_locations) | The ISO 3166-1-alpha-2 codes for which you want CloudFront to not distribute your content (blacklist) | `list(string)` | <pre>[<br>  "RU",<br>  "KP",<br>  "IR"<br>]</pre> | no |
| <a name="input_geo_restriction_type"></a> [geo\_restriction\_type](#input\_geo\_restriction\_type) | Method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist. | `string` | `"blacklist"` | no |
| <a name="input_index_document"></a> [index\_document](#input\_index\_document) | The default file that CloudFront will look for. | `string` | `"index.html"` | no |
| <a name="input_origin_shield_enabled"></a> [origin\_shield\_enabled](#input\_origin\_shield\_enabled) | Whether Origin Shield is enabled. | `bool` | `false` | no |
| <a name="input_origin_shield_region"></a> [origin\_shield\_region](#input\_origin\_shield\_region) | AWS Region for Origin Shield. To specify a region, use the region code, not the region name. For example, specify the US East (Ohio) region as us-east-2. | `string` | `"us-east-1"` | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | The price class for this distribution. One of PriceClass\_All, PriceClass\_200, PriceClass\_100. | `string` | `"PriceClass_100"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The project name. | `string` | n/a | yes |
| <a name="input_ssl_protocol_version"></a> [ssl\_protocol\_version](#input\_ssl\_protocol\_version) | Minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. | `string` | `"TLSv1.2_2021"` | no |
| <a name="input_ssl_support_method"></a> [ssl\_support\_method](#input\_ssl\_support\_method) | How you want CloudFront to serve HTTPS requests. One of vip or sni-only. | `string` | `"sni-only"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cdn_domain_name"></a> [cdn\_domain\_name](#output\_cdn\_domain\_name) | n/a |
<!-- END_TF_DOCS -->