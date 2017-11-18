variable acm_certificate_arn {}

variable aliases {
  description = "Array of aliases for the CloudFront distribution"
  type        = "list"
}

variable default_root_object {
  default = ""
  description = "The default object to show, e.g. index.html"
}

variable domain {
  description = "The domain name for the website being hosted, e.g. example.com"
}

variable duplicate_content_penalty_secret {
  description = "Secret/password used to restrict access to S3 to CloudFront"
}

variable environment {
  default = "default"
  description = "The label for the environment. Used for naming/tagging purposes"
}

variable "forward_query_string" {
  default     = false
  description = "Whether to forward the query string to the origin"
}

variable hosted_zone_id {
  description = "The Hosted Zone ID of the Route53 domain"
}

variable not_found_response_path {
  default = "/index.html"
  description = "The path to use when the requested resource can't be found"
}

variable project {
  default = "noproject"
  description = "The label for the project. Used for naming/tagging purposes"
}

variable region {
	description = "e.g. eu-central-1"
}

variable tags {
  default     = {}
  description = "Optional Tags"
  type        = "map"
}
