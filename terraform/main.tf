provider "aws" {
  region = lookup(var.master_props, "region")
}

module "master" {
  source = "./modules/instance"
  props = var.master_props
  instance_count = var.master_count
  env = var.env
  key_name = aws_key_pair.key_pair.key_name
  subnet_id = aws_subnet.k8s.id
  security_group_id = aws_security_group.k8s.id
}

module "cluster" {
  source = "./modules/instance"
  props = var.cluster_props
  instance_count = var.master_count
  env = var.env
  key_name = aws_key_pair.key_pair.key_name
  subnet_id = aws_subnet.k8s.id
  security_group_id = aws_security_group.k8s.id
}

resource "aws_key_pair" "key_pair" {
  key_name = var.key_name
  public_key = file(var.ssh_file)
}

resource "aws_vpc" "k8s" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = var.k8s_dns_support
  tags = {
    Name = var.tag_name
  }
}

resource "aws_subnet" "k8s" {
  vpc_id = aws_vpc.k8s.id
  cidr_block = var.subnet_cidr_block
  tags = {
    Name = var.tag_name
  }
}

resource "aws_security_group" "k8s" {
  name = var.tag_name
  vpc_id = aws_vpc.k8s.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    iterator = port 
    content {
      from_port = port.value
      to_port = port.value
      protocol = "tcp"
      cidr_blocks = [var.default_cidr_block]
    }
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [var.default_cidr_block]
  }

  tags = {
    Name = var.tag_name
  }
}

resource "aws_internet_gateway" "k8s" {
  vpc_id = aws_vpc.k8s.id
  tags = {
    Name = var.tag_name
  }
}

resource "aws_route_table" "k8s" {
  vpc_id = aws_vpc.k8s.id
  route {
    cidr_block = var.default_cidr_block
    gateway_id = aws_internet_gateway.k8s.id
  }
}

resource "aws_route_table_association" "k8s" {
  subnet_id = aws_subnet.k8s.id
  route_table_id = aws_route_table.k8s.id
}