variable "master_props" {
  type = map(any)
}

variable "cluster_props" {
  type = map(any)
}

variable "k8s_dns_support" {
  type = bool
  description = "Enable or disable dns support."
}

variable "master_count" {
  type        = number
  description = "No of master instances"
}

variable "cluster_count" {
  type        = number
  description = "No of cluster instances"
}

variable "env" {
  type        = string
  description = "Environment where this infrastructure is hosted"
}

variable "key_name" {
  type = string
  description = "Name for key pair."
}

variable "ssh_file" {
  type = string
  description = "Public key file for ssh connection."
}

variable "master_user_script" {
  type = string
  description = "User script to be executed in the master instance."
}

variable "cluster_user_script" {
  type = string
  description = "User script to be executed in the cluster instance."
}

variable "vpc_cidr_block" {
  description = "The CIDR block to associate to the VPC."
  type        = string
}

variable "subnet_cidr_block" {
  description = "The CIDR block to associate to the VPC."
  type        = string
}

variable "default_cidr_block" {
  description = "Allow connection from all IP address."
  type        = string
}

variable "name_tag" {
  type = string
  description = "Tag name for the resources."
}

variable "ingress_ports" {
  type = list(number)
  description = "List of ingress ports."
}