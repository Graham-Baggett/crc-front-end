output "gb-cloud-resume_bucket" {
    value = oci_objectstorage_bucket.create_bucket
}

output "private-security-list-name" {
  value = oci_core_security_list.private_security_list.display_name
}

output "public-security-list-name" {
  value = oci_core_security_list.public_security_list.display_name
}
