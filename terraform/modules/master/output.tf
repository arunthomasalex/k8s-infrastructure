output "ips" {
    value = aws_instance.master.*.public_ip
}

output "details" {
    value = aws_instance.master.*
}

output "count" {
    value = length(aws_instance.master)
}