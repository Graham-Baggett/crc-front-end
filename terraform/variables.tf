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
