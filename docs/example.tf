
module "s3_site" {
  source  = "madelabs/cloudfront-site/aws"
  version = "0.0.2"

  index_document        = "index.html"
  project_name          = "my-project"
  domain_alias          = "my.project.com"
  acm_certificate_arn   = "arn:aws:acm:us-east-1:1234567890123:certificate/123abcde-f345-6789-0123-9abcdefgh01"
  origin_shield_enabled = false
  origin_shield_region  = "us-east-1"
}
