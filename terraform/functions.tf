resource "oci_functions_application" "cloud_resume_application_application" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.application_name}"
  subnet_ids     = "TBD"
}

### Repository in the Container Image Registry for the container images underpinning the function 
resource "oci_artifacts_container_repository" "container_repository_for_function" {
    # note: repository = store for all images versions of a specific container image - so it included the function name
    compartment_id = var.compartment_ocid
    display_name = "${var.container_registry_name}/${var.website_display_function_name}"
    is_immutable = false
    is_public = false
}
