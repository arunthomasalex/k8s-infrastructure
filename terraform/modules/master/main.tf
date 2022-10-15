resource "aws_instance" "master" {
  ami = lookup(var.props, "ami")
  instance_type = lookup(var.props, "type")
  count = var.instance_count
  associate_public_ip_address = lookup(var.props, "enable_ip")
  key_name = var.key_name
  user_data = var.user_script != "" ? file(var.user_script) : ""
  tags = {
    Name = var.tag_name
    Environment = var.env
    Type = lookup(var.props, "tag")
  }
  root_block_device {
    delete_on_termination = true
    volume_size = 10
    volume_type = "gp2"
  }
  subnet_id = var.subnet_id
  vpc_security_group_ids = [ var.security_group_id ]
}