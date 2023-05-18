resource "oci_apigateway_gateway" "website_api_gateway" {
  compartment_id = var.compartment_ocid
  endpoint_type  = var.endpoint_type
  subnet_id      = oci_core_subnet.public_subnet.id
  lifecycle {
    prevent_destroy = false
  }
}

resource "oci_apigateway_deployment" "website_api_deployment" {
  #Required
  compartment_id = var.compartment_ocid
  gateway_id = data.oci_apigateway_gateway.website_api_gateway.id
  path_prefix = "/"
 
  specification {
    request_policies {
    }

    logging_policies {
      access_log {
        is_enabled = true
      }
      execution_log {
        is_enabled = true
      }
    }
    
    routes {
      #Required
      backend {
        #Required
        type = "ORACLE_FUNCTIONS_BACKEND"
        function_id = oci_functions_function.website_function.id
      }
      methods = ["GET"]
      path = "/{url*}"
    }
  }
  
  display_name = "website_api_deployment"
}

resource "oci_identity_policy" "api_gateway_fnpolicy" {
  compartment_id = var.compartment_ocid
  description    = "APIGW policy for compartment to access FN"
  name           = "apigateway_fn_policies"
  statements = [
    "ALLOW any-user to use functions-family in compartment id ${var.compartment_ocid} where ALL {request.principal.type= 'ApiGateway', request.resource.compartment.id = '${var.compartment_ocid}'}"
  ]
}
