resource "oci_apigateway_gateway" "website_api_gateway" {
  compartment_id = var.compartment_ocid
  endpoint_type  = var.endpoint_type
  subnet_id      = oci_core_subnet.public_subnet.id
  lifecycle {
    prevent_destroy = false
  }
}

resource "oci_identity_policy" "api_gateway_fnpolicy" {
  compartment_id = var.compartment_ocid
  description    = "APIGW policy for compartment to access FN"
  name           = "apigateway_fn_policies"
  statements = [
    "ALLOW any-user to use functions-family in compartment id ${var.compartment_ocid} where ALL {request.principal.type= 'ApiGateway', request.resource.compartment.id = '${var.compartment_ocid}'}"
  ]
}
