resource "oci_core_security_list" "public_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = "cloud-resume-challenge-public-security-list"
  
  egress_security_rules {
      stateless = var.egress_variables["stateless"]
      destination = "0.0.0.0/0"
      destination_type = var.egress_variables["source_type"]
      protocol = "all" 
  }

  ingress_security_rules { 
      stateless = var.ingress_variables["stateless"]
      source = "0.0.0.0/0"
      source_type = var.ingress_variables["source_type"]
      # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml TCP is 6
      protocol = "6"
      tcp_options { 
          min = 80
          max = 80
      }
    }
  
  ingress_security_rules { 
      stateless = var.ingress_variables["stateless"]
      source = "0.0.0.0/0"
      source_type = var.ingress_variables["source_type"]
      # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml TCP is 6
      protocol = "6"
      tcp_options { 
          min = 443
          max = 443
      }
    }
  
  ingress_security_rules { 
    stateless = var.ingress_variables["stateless"]
    source = "0.0.0.0/0"
    source_type = var.ingress_variables["source_type"]
    # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml TCP is 6
    protocol = "6"
    tcp_options { 
        min = 22
        max = 22
    } 
  }
  
  ingress_security_rules { 
      stateless = var.ingress_variables["stateless"]
      source = "0.0.0.0/0"
      source_type = var.ingress_variables["source_type"]
      # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml ICMP is 1  
      protocol = "1"
  
      # For ICMP type and code see: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
      icmp_options {
        type = 3
        code = 4
      } 
    }   
  
  ingress_security_rules { 
      stateless = var.ingress_variables["stateless"]
      source = "10.0.0.0/16"
      source_type = var.ingress_variables["source_type"]
      # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml ICMP is 1  
      protocol = "1"
  
      # For ICMP type and code see: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
      icmp_options {
        type = 3
      } 
    }
}

resource "oci_core_security_list" "private_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = "cloud-resume-challenge-private-security-list"
  
  egress_security_rules {
      stateless = var.egress_variables["stateless"]
      destination = "0.0.0.0/0"
      destination_type = var.egress_variables["source_type"]
      protocol = "all" 
  }
  
  ingress_security_rules { 
    stateless = var.ingress_variables["stateless"]
    source = "10.0.0.0/16"
    source_type = var.ingress_variables["source_type"]
    # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml TCP is 6
    protocol = "6"
    tcp_options { 
        min = 22
        max = 22
    }
  }
  
  ingress_security_rules { 
    stateless = var.ingress_variables["stateless"]
    source = "0.0.0.0/0"
    source_type = var.ingress_variables["source_type"]
    # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml ICMP is 1  
    protocol = "1"
  
    # For ICMP type and code see: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
    icmp_options {
      type = 3
      code = 4
    } 
  }   
  
  ingress_security_rules { 
    stateless = var.ingress_variables["stateless"]
    source = "10.0.0.0/16"
    source_type = var.ingress_variables["source_type"]
    # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml ICMP is 1  
    protocol = "1"
  
    # For ICMP type and code see: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
    icmp_options {
      type = 3
    } 
  }
}
