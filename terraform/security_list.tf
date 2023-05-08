resource "oci_core_security_list" "public_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = "cloud-resume-challenge-public-security-list"
  
  ingress_security_rules {
    description = "Main VCN Ingress Rules"
    protocol    = var.ingress["protocol"]
    source      = var.ingress["source"]
    stateless   = var.ingress["stateless"]
  }
}
