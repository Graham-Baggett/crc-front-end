data "oci_functions_applications" "crc_function_applications" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.application_name}"
}

locals {
  application_id = data.oci_functions_applications.crc_function_applications.applications[0].id
}
