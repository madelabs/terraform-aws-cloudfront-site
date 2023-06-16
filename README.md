# terraform-aws-cloudfront-site
A Terraform module for managing a S3 hosted web application that is behind CloudFront CDN.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.s3_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.origin_access_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_s3_bucket.cloudfront_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.east_website_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.cloudfront_logging_bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_policy.east_bucket_read_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_wafv2_ip_set.allowed_ipset](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_ip_set) | resource |
| [aws_wafv2_web_acl.allow_specific_ips_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_iam_policy_document.east_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | The arn for the ACM certificate to be used with the domain\_alias. | `string` | n/a | yes |
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | The list of IP addresses to allow access to the cloudfront distribution | `list(string)` | `[]` | no |
| <a name="input_allowed_traffic_cloudwatch_metrics_enabled"></a> [allowed\_traffic\_cloudwatch\_metrics\_enabled](#input\_allowed\_traffic\_cloudwatch\_metrics\_enabled) | Whether or not to enable the metrics for the allowed traffic rule. | `bool` | `true` | no |
| <a name="input_allowed_traffic_sampled_requests_enabled"></a> [allowed\_traffic\_sampled\_requests\_enabled](#input\_allowed\_traffic\_sampled\_requests\_enabled) | Whether or not to enable the sampled requests (3hr) for the allowed traffic rule. | `bool` | `true` | no |
| <a name="input_apply_waf_cdn"></a> [apply\_waf\_cdn](#input\_apply\_waf\_cdn) | Wether or not to enable the restriction of IP addresses. | `bool` | `false` | no |
| <a name="input_blacklist"></a> [blacklist](#input\_blacklist) | The ISO 3166-1-alpha-2 codes for which you want CloudFront to not distribute your content (blacklist) | `list(string)` | <pre>[<br>  "RU",<br>  "KP",<br>  "IR"<br>]</pre> | no |
| <a name="input_blocked_traffic_cloudwatch_metrics_enabled"></a> [blocked\_traffic\_cloudwatch\_metrics\_enabled](#input\_blocked\_traffic\_cloudwatch\_metrics\_enabled) | Whether or not to enable the metrics for the blocked traffic rule. | `bool` | `true` | no |
| <a name="input_blocked_traffic_sampled_requests_enabled"></a> [blocked\_traffic\_sampled\_requests\_enabled](#input\_blocked\_traffic\_sampled\_requests\_enabled) | Whether or not to enable the sampled requests (3hr) for the blocked traffic rule. | `bool` | `true` | no |
| <a name="input_create_waf"></a> [create\_waf](#input\_create\_waf) | Enable or disable the creation of WAFv2 Web ACL resources. | `bool` | `false` | no |
| <a name="input_default_ttl"></a> [default\_ttl](#input\_default\_ttl) | The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header | `number` | `60` | no |
| <a name="input_domain_alias"></a> [domain\_alias](#input\_domain\_alias) | The domain alias to apply to your distribution. Example: devconnectenterprise.kehe.com | `string` | n/a | yes |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `true` | no |
| <a name="input_index_document"></a> [index\_document](#input\_index\_document) | The default file that CloudFront will look for. | `string` | `"index.html"` | no |
| <a name="input_max_ttl"></a> [max\_ttl](#input\_max\_ttl) | The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. | `number` | `120` | no |
| <a name="input_min_ttl"></a> [min\_ttl](#input\_min\_ttl) | The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds | `number` | `0` | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | The price class for this distribution. One of PriceClass\_All, PriceClass\_200, PriceClass\_100. | `string` | `"PriceClass_100"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The project name. | `string` | n/a | yes |
| <a name="input_ssl_protocol_version"></a> [ssl\_protocol\_version](#input\_ssl\_protocol\_version) | Minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. | `string` | `"TLSv1.2_2021"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cdn_domain_name"></a> [cdn\_domain\_name](#output\_cdn\_domain\_name) | n/a |
<!-- END_TF_DOCS -->