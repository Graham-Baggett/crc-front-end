variable "application_name" {
  type        = string
  default     = "cloud-resume-challenge-app"
  description = "Name of Cloud Resume Challenge Application"
}

variable "bucket_access_type" {
  type        = string
  default     = "ObjectRead"
  description = "Access Policy for Cloud Resume Challenge bucket"
} 

variable "bucket_name" {
  type        = string
  default     = "gb-cloud-resume"
  description = "Bucket name for Cloud Resume Challenge"
}

variable "bucket_namespace" {
  type        = string
  description = "OCI namespace"
}

variable "compartment_ocid" {
  type        = string
  description = "OCID for the cloud-resume-challenge compartment"
}

variable "container_registry_name" {
  type        = string
  default     = "cloud-resume-challenge/functions"
  description = "Name of the OCI Container Registry"
}

variable "domain_name" {
  type        = string
  default     = "grahambaggett.net"
  description = "Domain Name for Cloud Resume Challenge"
}

variable "endpoint_type" {
  type        = string
  default     = "PUBLIC"
  description = "Type of API Gateway Endpoint"
}

variable "egress_variables" {
  default = {
    source_type = "CIDR_BLOCK"
    stateless = false
  }
}

variable "function_name" {
  type        = string
  default     = "get_website"
  description = "Website Retrieval OCI Function Name"
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
  default     = "HTTPS"
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

variable "http_redirect_response_code" {
  type        = number
  default     = 302
  description = "HTTP Redirect response code"
}

variable "http_redirect_target_query" {
  type        = string
  default     = ""
  description = "Query string for the rule redirecting traffic from the custom domain to the Cloud Resume Challenge website bucket"
}

variable "ingress_variables" {
  default = {
    source_type = "CIDR_BLOCK"
    stateless = false
  }
}

variable "log_retention_duration" {
  type        = number
  default     = 30
  description = "Log retention duration"
}

variable "logdefinition" {
  type = map(any)
  default = {
    loggroup = "funcloggroup"
    service = "functions"
    resource = "cloud-resume-challenge-app"
  }
}

variable "loggroup" {
  type = map(any)
  description = "Log Group"
}

variable "private_subnet_cidr_block" {
  type        = string
  default     = "10.0.1.0/24"
  description = "Classless Inter-Domain Routing block for the private subnet of the Cloud Resume Challenge OCI Virtual Cloud Network"
}

variable "public_subnet_cidr_block" {
  type        = string
  default     = "10.0.2.0/24"
  description = "Classless Inter-Domain Routing block for the public subnet of the Cloud Resume Challenge OCI Virtual Cloud Network"
}

variable "region" {
  type        = string
  description = "OCI region"
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

#value defined in the variables section in OCI Resource Manager
variable "tenancy_ocid" {
  type        = string
  description = "Tenancy OCID"
}

variable "vnc_cidr_block" {
  type        = list
  default     = ["10.0.0.0/16"]
  description = "Classless Inter-Domain Routing block for the Cloud Resume Challenge OCI Virtual Cloud Network"
}

variable "website_display_function_name" {
  type        = string
  default     = "website-display-function"
  description = "Name of the function that returns the index.html file"
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

locals {
  ocir_repo_name = "cloud-resume-challenge/functions"  
  ocir_docker_repository = join("", [lower(lookup(data.oci_identity_regions.oci_regions.regions[0], "key")), ".ocir.io"])
  ocir_namespace         = lookup(data.oci_objectstorage_namespace.os_namespace, "namespace")
}
