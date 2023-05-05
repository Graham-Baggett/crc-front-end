resource "oci_dns_zone" "hosted_zone" {
    #Required
    compartment_id = var.compartment_ocid
    name = var.zone_name
    zone_type = var.zone_type
}

# resource "oci_dns_rrset" "zone_rrset" {
#     #Required
#     domain = var.rrset_domain
#     rtype = var.rrset_a_rtype
#     zone_name_or_id = oci_dns_zone.hosted_zone.id
    
#     items {
#         #Required
#         domain = var.rrset_domain
#         rdata = var.rrset_items_rdata
#         rtype = var.rrset_a_rtype
#         ttl = var.rrset_items_ttl
#     }
# }

resource "oci_waas_http_redirect" "custom_domain_http_redirect" {
    #Required
    compartment_id = var.compartment_ocid
    domain = var.domain_name
    target {
        #Required
        host = var.http_redirect_target_host
        path = var.http_redirect_target_path
        protocol = var.http_redirect_target_protocol

        #Optional
        port = var.http_redirect_target_port
    }

    #Optional
    display_name = var.http_redirect_display_name
    response_code = var.http_redirect_response_code
}
