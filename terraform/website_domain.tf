resource "oci_dns_zone" "hosted_zone" {
    #Required
    compartment_id = var.compartment_ocid
    name = var.zone_name
    zone_type = var.zone_type
}

resource "oci_dns_rrset" "zone_rrset" {
    #Required
    domain = var.rrset_domain
    rtype = var.rrset_a_rtype
    zone_name_or_id = oci_dns_zone.hosted_zone.id
}
