resource "oci_functions_application" "cloud_resume_challenge_application" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.application_name}"
  subnet_ids     = [oci_core_subnet.public_subnet.id]
}

### Repository in the Container Image Registry for the container images underpinning the function 
resource "oci_artifacts_container_repository" "container_repository_for_function" {
    # note: repository = store for all images versions of a specific container image - so it included the function name
    compartment_id = var.compartment_ocid
    display_name = "${var.container_registry_name}/${var.website_display_function_name}"
    is_immutable = false
    is_public = false
}

resource "oci_functions_function" "website_function" {
  application_id = "${local.application_id}"
  display_name   = "${var.function_name}"
  image          = "${local.ocir_docker_repository}/${local.ocir_namespace}/${local.ocir_repo_name}/${var.function_name}:0.0.1"
  memory_in_mbs  = "128"
}

### wait a little while before the function is ready to be invoked to avoid the below error
## Error: 404-NotAuthorizedOrNotFound 
## Error Message: Authorization failed or requested resource not found 
##│Suggestion: Either the resource has been deleted or service Functions Invoke Function need policy to access this resource. 
resource "time_sleep" "wait_for_function_to_be_ready" {
  depends_on = [oci_functions_function.website_function]
  create_duration = "10s"
}

resource "oci_functions_invoke_function" "test_invoke_website_function" {
  depends_on     = [time_sleep.wait_for_function_to_be_ready]
    #Required
    function_id = oci_functions_function.website_function.id

    #Optional
    fn_intent = "httprequest"
    fn_invoke_type = "sync" 
    base64_encode_content = false
}

output "function_response" {
  value = oci_functions_invoke_function.test_invoke_website_function.content
}
