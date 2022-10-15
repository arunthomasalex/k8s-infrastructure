output "ips" {
    value = aws_instance.cluster.*.public_ip
}

output "details" {
    value = aws_instance.cluster.*
}

output "count" {
    value = length(aws_instance.cluster)
}