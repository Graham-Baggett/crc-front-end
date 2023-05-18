output "api_gateway" {
  value = {
    ips      = data.oci_apigateway_gateway.website_api_gateway.ip_addresses
    hostname = data.oci_apigateway_gateway.website_api_gateway.hostname
  }
}

output "website_api_endpoint" {
    value = oci_apigateway_deployment.api_gateway_deployment.endpoint
}

output "gb-cloud-resume_bucket" {
    value = oci_objectstorage_bucket.create_bucket
}

output "private-security-list-name" {
  value = oci_core_security_list.private_security_list.display_name
}

output "public-security-list-name" {
  value = oci_core_security_list.public_security_list.display_name
}
