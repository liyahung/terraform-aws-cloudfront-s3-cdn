################################################################################################################
## Create a Cloudfront distribution
################################################################################################################
resource "aws_cloudfront_distribution" "cdn" {
  aliases = "${var.aliases}"
  default_root_object = "${var.default_root_object}"

  # If there is a 404, return index.html with a HTTP 200 Response
  custom_error_response {
    error_code            = "404"
    error_caching_min_ttl = "360"
    response_code         = "200"
    response_page_path    = "${var.not_found_response_path}"
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    # Forward (to origin) settings
    "forwarded_values" {
      query_string = "${var.forward_query_string}"

      cookies {
        forward = "none"
      }
    }

    min_ttl          = "0"
    default_ttl      = "300"  //3600
    max_ttl          = "1200" //86400

    target_origin_id = "origin-bucket-${var.domain}"

    // This redirects any HTTP request to HTTPS. Security first!
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }

  enabled       = true
  http_version  = "http1.1"

  origin {
    origin_id   = "origin-bucket-${var.domain}"
    domain_name = "${var.domain}.s3-website-${var.region}.amazonaws.com"

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    custom_header {
      name  = "User-Agent"
      value = "${var.duplicate_content_penalty_secret}"
    }
  }

  price_class   = "PriceClass_All"

  # Restrictions for who is able to access this content
  restrictions {
    "geo_restriction" {
      # type of restriction, blacklist, whitelist or none
      restriction_type = "none"
    }
  }

  tags = "${merge("${var.tags}",map("Name", "${var.project}-${var.domain}", "Environment", "${var.environment}", "Project", "${var.project}"))}"

  # SSL certificate for the service.
  viewer_certificate {
    acm_certificate_arn      = "${var.acm_certificate_arn}"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }
}
