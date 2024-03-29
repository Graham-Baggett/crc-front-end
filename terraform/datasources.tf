data "oci_functions_applications" "crc_function_applications" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.application_name}"
}

locals {
  application_id = data.oci_functions_applications.crc_function_applications.applications[0].id
}

#data "oci_apigateway_gateway" "website_api_gateway" {
#    #Required
#    gateway_id = oci_apigateway_gateway.website_api_gateway.id
#}

# Gets home and current regions
data "oci_identity_tenancy" "tenant_details" {
  tenancy_id = var.tenancy_ocid
}

data "oci_identity_regions" "home_region" {
  filter {
    name   = "key"
    values = [data.oci_identity_tenancy.tenant_details.home_region_key]
  }
}


data "oci_identity_tenancy" "oci_tenancy" {
  tenancy_id = var.tenancy_ocid
}

# OCI Services
## Available Services
data "oci_core_services" "all_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

data "oci_identity_regions" "oci_regions" {

  filter {
    name   = "name"
    values = [var.region]
  }

}

data "oci_objectstorage_namespace" "os_namespace" {
  compartment_id = var.tenancy_ocid
}
