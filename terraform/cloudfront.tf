locals {
  content_security_policy = "default-src 'none'; font-src 'self' https://fonts.googleapis.com https://cdn.jsdelivr.net https://fonts.gstatic.com; connect-src 'self' ${var.api_url}; img-src 'self'; script-src 'self'; base-uri 'none'; form-action 'none'; style-src 'self' https://cdn.jsdelivr.net https://fonts.googleapis.com; frame-ancestors 'none'; manifest-src 'self'"
}

resource "aws_cloudfront_origin_access_control" "web_bucket_access_policy" {
  name                              = "allow_to_s3_from_cloud_front"
  description                       = "Allows access to an S3 web bucket from CloudFront"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_response_headers_policy" "security_headers_policy" {
  name = "my-security-headers-policy"
  security_headers_config {
    content_type_options {
      override = true
    }
    frame_options {
      frame_option = "DENY"
      override     = true
    }
    referrer_policy {
      referrer_policy = "strict-origin-when-cross-origin"
      override        = true
    }
    xss_protection {
      mode_block = true
      protection = true
      override   = true
    }
    strict_transport_security {
      access_control_max_age_sec = "63072000"
      include_subdomains         = true
      preload                    = true
      override                   = true
    }
    content_security_policy {
      content_security_policy = local.content_security_policy
      override                = true
    }
  }
}

resource "aws_cloudfront_distribution" "web_distribution" {
  origin {
    domain_name              = aws_s3_bucket.my_website_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.web_bucket_access_policy.id
    origin_id                = aws_s3_bucket.my_website_bucket.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for our Website"
  default_root_object = "html/index.html"

  aliases = [var.domain_name, "www.${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.my_website_bucket.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0

    response_headers_policy_id = aws_cloudfront_response_headers_policy.security_headers_policy.id
  }

  # For this lab, we only deploy to minimal regions.
  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.certificate.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = var.minimum_protocol_version

  }

  tags = {
    Name = "CloudResumeChallengeCloudFront"
  }

}
