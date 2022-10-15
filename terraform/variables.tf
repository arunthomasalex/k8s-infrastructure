variable "master_props" {
  type = map(any)
  default = {
    region     = "ap-south-1"
    ami        = "ami-068257025f72f470d"
    type       = "t2.micro"
    enable_ip  = true
    enable_dns = true
    tag   = "master"
  }
}

variable "cluster_props" {
  type = map(any)
  default = {
    region     = "ap-south-1"
    ami        = "ami-068257025f72f470d"
    type       = "t2.micro"
    enable_ip  = true
    enable_dns = true
    tag   = "cluster"
  }
}

variable "k8s_dns_support" {
  type = bool
  description = "Enable or disable dns support."
  default = true
}

variable "master_count" {
  type        = number
  description = "No of master instances"
  default     = 1
}

variable "cluster_count" {
  type        = number
  description = "No of cluster instances"
  default     = 1
}

variable "env" {
  type        = string
  description = "Environment where this infrastructure is hosted"
  default     = "dev"
}

variable "key_name" {
  type = string
  description = "Name for key pair."
  default = "k8s"
}

variable "ssh_file" {
  type = string
  description = "Public key file for ssh connection."
  default = "../config/sshkey.pub"
}

variable "master_user_script" {
  type = string
  description = "User script to be executed in the master instance."
  default = ""
}

variable "cluster_user_script" {
  type = string
  description = "User script to be executed in the cluster instance."
  default = ""
}

variable "vpc_cidr_block" {
  description = "The CIDR block to associate to the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "The CIDR block to associate to the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "default_cidr_block" {
  description = "Allow connection from all IP address."
  type        = string
  default     = "0.0.0.0/0"
}

variable "tag_name" {
  type = string
  description = "Tag name for the resources."
  default = "k8s"
}

variable "ingress_ports" {
  type = list(number)
  description = "List of ingress ports."
  default     = [22, 80, 443]
}