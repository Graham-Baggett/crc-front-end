### Repository in the Container Image Registry for the container images underpinning the function 
resource "oci_artifacts_container_repository" "container_repository_for_function" {
    # note: repository = store for all images versions of a specific container image - so it included the function name
    compartment_id = var.ocid_compartment_ocid
    display_name = "${local.ocir_repo_name}/${var.function_name}"
    is_immutable = false
    is_public = false
}
