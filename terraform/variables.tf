variable "compartment_ocid" {
  type        = string
  description = "OCID for the cloud-resume-challenge compartment"
}

variable "region" {
  type        = string
  default     = "us-ashburn-1"
  description = "OCI region"
}

variable "bucket_namespace" {
  type        = string
  description = "OCI namespace"
}

variable "bucket_name" {
  type        = string
  default     = "gb-cloud-resume"
  description = "Bucket name for Cloud Resume Challenge"
}

variable "bucket_access_type" {
  type        = string
  default     = "ObjectRead"
  description = "Access Policy for Cloud Resume Challenge bucket"
} 

variable "zone_name" {
  type        = string
  default     = "grahambaggett.net"
  description = "Name of Hosted Zone for Cloud Resume Challenge"
}

variable "zone_type" {
  type        = string
  default     = "PRIMARY"
  description = "Hosted Zone Type for Cloud Resume Challenge"
}

variable "domain_name" {
  type        = string
  default     = "grahambaggett.net"
  description = "Domain Name for Cloud Resume Challenge"
}

variable "rrset_a_rtype" {
  type        = string
  default     = "A"
  description = "'A' DNS Record for Cloud Resume Challenge"
}

variable "rrset_items_rdata" {
  type        = string
  default     = "objectstorage.us-ashburn-1.oraclecloud.com."
  description = "Domain where Cloud Resume Challenge website resides"
}

variable "rrset_items_ttl" {
  type        = number
  default     = 3600
  description = "Domain where Cloud Resume Challenge website resides"
}

variable "http_redirect_target_host" {
  type        = string
  default     = "objectstorage.us-ashburn-1.oraclecloud.com"
  description = "Base URL where Cloud Resume Challenge website resides"
}

variable "http_redirect_target_path" {
  type        = string
  default     = "/n/idixwybnkjfi/b/gb-cloud-resume/o/html/index.html"
  description = "Path where Cloud Resume Challenge index site resides"
}

variable "http_redirect_target_protocol" {
  type        = string
  default     = "https"
  description = "TCP/IP Protocol for the Cloud Resume Challenge website"
}

variable "http_redirect_target_port" {
  type        = number
  default     = 443
  description = "TCP/IP Protocol Port for the Cloud Resume Challenge website"
}

variable "http_redirect_display_name" {
  type        = string
  default     = "Custom Domain HTTP Redirect Rule"
  description = "Rule for redirecting traffic from custom domain to Cloud Resume Challenge website bucket"
}
