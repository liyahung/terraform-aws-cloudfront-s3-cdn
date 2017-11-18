# terraform-aws-cloudfront-s3-cdn
Terraform module to provision a CloudFront CDN backed by an S3 origin

## Usage

#### Provision an S3 origin backed CloudFront CDN

```hcl
module cdn {
  source                            = "git::https://github.com/richardkdrew/terraform-aws-cloudfront-s3-cdn.git?ref=master"

  acm_certificate_arn               = "${var.acm_certificate_arn}"
  aliases                           = "${var.aliases}"
  domain                            = "${var.domain}"
  duplicate_content_penalty_secret  = "${var.duplicate_content_penalty_secret}"
  environment                       = "${var.environment}"
  hosted_zone_id                    = "${var.hosted_zone_id}"
  project                           = "${var.project}"
  region                            = "${var.region}"
}
```

## Variables

|  Name                              |  Default       |  Description                                                                        |  Required |
|:-----------------------------------|:--------------:|:------------------------------------------------------------------------------------|:---------:|
...work in progress...


## Outputs

| Name                           | Description                                                 |
|:------------------------------ |:------------------------------------------------------------|
| `cdn_hostname`                 | Domain/Host name corresponding to the distribution          |
| `cdn_zone_id`                  | CloudFront Route 53 zone ID                                 |
