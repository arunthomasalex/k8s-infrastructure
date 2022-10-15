variable "master_props" {
  type = map(any)
  default = {
    region     = "ap-south-1"
    ami        = "ami-068257025f72f470d"
    type       = "t2.micro"
    enable_ip  = true
    enable_dns = true
    name_tag   = "k8s_master"
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
    name_tag   = "k8s_cluster"
  }
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
