resource "oci_apigateway_gateway" "website_api_gateway" {
  compartment_id = var.compartment_ocid
  endpoint_type  = var.endpoint_type
  subnet_id      = oci_core_subnet.public_subnet.id
  lifecycle {
    prevent_destroy = false
  }
}
