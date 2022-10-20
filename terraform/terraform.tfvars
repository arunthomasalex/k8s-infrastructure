master_props = {
  region     = "ap-south-1"
  ami        = "ami-068257025f72f470d"
  type       = "t2.micro"
  enable_ip  = true
  name       = "master"
}
cluster_props = {
  region     = "ap-south-1"
  ami        = "ami-068257025f72f470d"
  type       = "t2.micro"
  enable_ip  = true
  name       = "cluster"
}
k8s_dns_support     = true
master_count        = 1
cluster_count       = 2
env                 = "dev"
key_name            = "k8s"
ssh_file            = "../config/sshkey.pub"
master_user_script  = ""
cluster_user_script = ""
vpc_cidr_block      = "10.0.0.0/16"
subnet_cidr_block   = "10.0.1.0/24"
default_cidr_block  = "0.0.0.0/0"
name_tag            = "k8s"
ingress_ports       = [22, 80, 443]
