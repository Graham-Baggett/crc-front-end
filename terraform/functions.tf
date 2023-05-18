resource "oci_functions_application" "cloud_resume_challenge_application" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.application_name}"
  subnet_ids     = [oci_core_subnet.public_subnet.id]
}

### Repository in the Container Image Registry for the container images underpinning the function 
resource "oci_artifacts_container_repository" "container_repository_for_function" {
    # note: repository = store for all images versions of a specific container image - so it included the function name
    compartment_id = var.compartment_ocid
    display_name = "${var.container_registry_name}/${var.function_name}"
    is_immutable = false
    is_public = false
}

# resource "oci_functions_function" "website_function" {
#   application_id = "${local.application_id}"
#   display_name   = "${var.function_name}"
#   image          = "${local.ocir_docker_repository}/${local.ocir_namespace}/${local.ocir_repo_name}/${var.function_name}:0.0.1"
#   memory_in_mbs  = "128"
# }

resource "oci_logging_log_group" "crc_log_group" {
    #Required
    compartment_id = var.compartment_ocid
    display_name = "website-function-log-group"
}

resource "oci_logging_log" "crc_log" {
    #Required
    display_name = "website-function-log"
    log_group_id = oci_logging_log_group.crc_log_group.id
    log_type = "SERVICE"

    #Optional
    configuration {
        #Required
        source {
            #Required
            category = "invoke"
            resource = oci_functions_application.cloud_resume_challenge_application.id
            service = "functions"
            source_type = "OCISERVICE"
        }

        #Optional
        compartment_id = var.compartment_ocid
    }

    retention_duration = var.log_retention_duration
}
