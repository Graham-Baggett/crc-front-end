# Create the main OCI VCN 
resource "oci_core_vcn" "main_vcn" {
  cidr_blocks    = var.vnc_cidr_block
  compartment_id = var.compartment_ocid
  is_ipv6enabled = false
  display_name   = "cloud-resume-challenge-vcn"
}

# Create the DHCP Options
resource "oci_core_dhcp_options" "dhcp" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = "cloud-resume-challenge-dhcp-options"

  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  options {
    type                = "SearchDomain"
    search_domain_names = ["grahambaggett.net"]
  }
}

# Create the Internet Gateway
resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = "cloud-resume-challenge-internet-gateway"
}

# Create a Route Table for the Internet Gateway
resource "oci_core_route_table" "igw_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = "cloud-resume-challenge-internet-gateway-route-table"
  
  route_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

# Create a Public Subnet
resource "oci_core_subnet" "public_subnet" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  cidr_block     = var.vnc_public_subnet_cidr_block
  display_name   = "cloud-resume-challenge-public-subnet"

  route_table_id    = oci_core_route_table.igw_route_table.id
  dhcp_options_id   = oci_core_dhcp_options.dhcp.id
  security_list_ids = [oci_core_security_list.public_security_list.id]
}

# Create a NAT Gateway
resource "oci_core_nat_gateway" "nat_gateway" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = "cloud-resume-challenge-network-address-translation-gateway"
}

# Create a Route Table for the NAT Gateway
resource "oci_core_route_table" "nat_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = "cloud-resume-challenge-network-address-translation-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }
}

# Create a Private Subnet
resource "oci_core_subnet" "private_subnet" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  cidr_block     = var.private_subnet_cidr_block
  display_name   = "cloud-resume-challenge-private-subnet"

  prohibit_public_ip_on_vnic = true

  route_table_id    = oci_core_route_table.igw_route_table.id
  dhcp_options_id   = oci_core_dhcp_options.dhcp.id
  security_list_ids = [oci_core_security_list.private_security_list.id]
}
