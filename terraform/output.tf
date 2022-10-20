output "k8s-master-ips" {
  value = module.master.ips
}

output "k8s-master-details" {
  value = module.master.details
}

output "k8s-master-count" {
  value = module.master.count
}

output "k8s-cluster-ips" {
  value = module.cluster.ips
}

output "k8s-cluster-details" {
  value = module.cluster.details
}

output "k8s-cluster-count" {
  value = module.cluster.count
}

output "k8s-master-ids" {
  value = module.master.ids
}

output "k8s-cluster-ids" {
  value = module.cluster.ids
}
