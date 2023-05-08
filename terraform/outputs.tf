output "private-security-list-name" {
  value = oci_core_security_list.private-security-list.display_name
}


output "gb-cloud-resume_bucket" {
    value = oci_objectstorage_bucket.create_bucket
}
