output "api_gateway_id" {
    value = "${aws_api_gateway_deployment.example.invoke_url}/${aws_api_gateway_resource.proxy.path_part}"
    description = "The ID of the REST API"
}
