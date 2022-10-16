variable "props" {
  type = map(any)
  description = "Basic properties"
}


variable "instance_count" {
  type        = number
  description = "No of master instances"
}

variable "env" {
  type        = string
  description = "Environment where this infrastructure is hosted"
}

variable "user_script" {
  type = string
  description = "User script to be executed in the master instance."
  default = ""
}

variable "key_name" {
  type = string
  description = "Name for key pair."
}

variable "subnet_id" {
  type = string
  description = "Selected subnet id"
}

variable "security_group_id" {
  type = string
  description = "Selected security group id"
}

variable "name_tag" {
  type = string
  description = "Tag name for the resource"
}