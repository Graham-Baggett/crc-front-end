resource "oci_dns_zone" "hosted_zone" {
    #Required
    compartment_id = var.compartment_ocid
    name = var.zone_name
    zone_type = var.zone_type
}
