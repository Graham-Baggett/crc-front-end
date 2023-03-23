variable "domain_name" {
  type        = string
  default     = "grahambaggett.com"
  description = "Custom domain name"
}

variable "bucket_name" {
  type        = string
  default     = "gb-cloud-resume"
  description = "Custom domain name"
}

variable "api_url" {
  type        = string
  default     = "https://r31nk3e4ck.execute-api.us-east-1.amazonaws.com"
  description = "API Gateway URL for Lambda Visitor Count functions"
}

variable "minimum_protocol_version" {
  type        = string
  default     = "TLSv1.2_2021"
  description = "Version of Transport Layer Security"
}
