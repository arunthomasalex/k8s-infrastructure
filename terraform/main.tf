provider "aws" {
  region = lookup(var.master_props, "region")
}

resource "aws_instance" "k8s_master" {
  ami = lookup(var.master_props, "ami")
  instance_type = lookup(var.master_props, "type")
  count = var.master_count
  associate_public_ip_address = lookup(var.master_props, "enable_ip")
  tags = {
    Name = lookup(var.master_props, "name_tag")
    Environment = var.env
  }
  root_block_device {
    delete_on_termination = true
    volume_size = 10
    volume_type = "gp2"
  }
}

resource "aws_instance" "k8s_cluster" {
  ami = lookup(var.cluster_props, "ami")
  instance_type = lookup(var.cluster_props, "type")
  count = var.cluster_count
  associate_public_ip_address = lookup(var.cluster_props, "enable_ip")
  tags = {
    Name = lookup(var.cluster_props, "name_tag")
    Environment = var.env
  }
  root_block_device {
    delete_on_termination = true
    volume_size = 10
    volume_type = "gp2"
  }
}