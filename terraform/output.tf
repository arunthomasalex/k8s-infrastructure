output "k8s-master" {
    value = aws_instance.k8s_master.*.public_ip
}

output "k8s-cluster" {
    value = aws_instance.k8s_cluster.*.public_ip
}

output "k8s-master-details" {
    value = aws_instance.k8s_master.*
}

output "k8s-cluster-details" {
    value = aws_instance.k8s_cluster.*
}

output "k8s-master-count" {
    value = length(aws_instance.k8s_master)
}

output "k8s-cluster-count" {
    value = length(aws_instance.k8s_cluster)
}