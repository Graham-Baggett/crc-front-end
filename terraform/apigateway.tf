#resource "oci_apigateway_gateway" "website_api_gateway" {
#  certificate_id = var.certificate_ocid
#  compartment_id = var.compartment_ocid
#  display_name   = "Cloud Resume Challenge Website API Gateway"
#  endpoint_type  = var.endpoint_type
#  subnet_id      = oci_core_subnet.public_subnet.id
#  lifecycle {
#    prevent_destroy = false
#  }
#}
#
#resource "oci_apigateway_deployment" "website_api_deployment" {
#  #Required
#  compartment_id = var.compartment_ocid
#  display_name = "website_api_deployment"
#  gateway_id = data.oci_apigateway_gateway.website_api_gateway.id
#  path_prefix = "/"
# 
#  specification {
#    request_policies {
#    }
#
#    logging_policies {
#      access_log {
#        is_enabled = true
#      }
#      execution_log {
#        is_enabled = true
#        log_level = "INFO"
#      }
#    }
#   
#    routes {
#      #Required
#      backend {
#        #Required
#        type = "ORACLE_FUNCTIONS_BACKEND"
#        function_id = oci_functions_function.website_function.id
#      }
#      methods = ["GET"]
#      path = "/{url*}"
#    }
#  }
#}
#
#resource "oci_identity_policy" "api_gateway_fnpolicy" {
#  compartment_id = var.compartment_ocid
#  description    = "APIGW policy for compartment to access FN"
#  name           = "apigateway_fn_policies"
#  statements = [
#    "ALLOW any-user to use functions-family in compartment id ${var.compartment_ocid} where ALL {request.principal.type= 'ApiGateway', request.resource.compartment.id = '${var.compartment_ocid}'}"
#  ]
#}
#
#resource "oci_logging_log_group" "api_log_group" {
#    #Required
#    compartment_id = var.compartment_ocid
#    display_name = "website-api-gateway-log-group"
#}
#
#resource "oci_logging_log" "api_access_log" {
#    #Required
#    display_name = "website-api-gateway-log"
#    log_group_id = oci_logging_log_group.api_log_group.id
#    log_type = "SERVICE"
#
#    #Optional
#    configuration {
#        #Required
#        source {
#            #Required
#            category = "access"
#            resource = oci_apigateway_deployment.website_api_deployment.id
#            service = "apigateway"
#            source_type = "OCISERVICE"
#        }
#
#        #Optional
#        compartment_id = var.compartment_ocid
#    }
#
#    retention_duration = var.log_retention_duration
#}
#
#resource "oci_logging_log" "api_execution_log" {
#    #Required
#    display_name = "website-api-gateway-execution-log"
#    log_group_id = oci_logging_log_group.api_log_group.id
#    log_type = "SERVICE"
#
#    #Optional
#    configuration {
#        #Required
#        source {
#            #Required
#            category = "execution"
#            resource = oci_apigateway_deployment.website_api_deployment.id
#            service = "apigateway"
#            source_type = "OCISERVICE"
#        }
#
#        #Optional
#        compartment_id = var.compartment_ocid
#    }
#
#    retention_duration = var.log_retention_duration
#}
