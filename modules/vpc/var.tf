variable "vpc_cidr_c" {
  type    = string
  default = "10.0.0.0/16"

}


variable "vpc_name_c" {

  default = "vault_vpc"

}

variable "pub_sub1_cidr_block_c" {
  type    = string
  default = "10.0.101.0/24"

}



variable "pub_sub2_cidr_block_c" {
  type    = string
  default = "10.0.102.0/24"

}


variable "prv_sub1_cidr_block_c" {
  type    = string
  default = "10.0.1.0/24"

}


variable "prv_sub2_cidr_block_c" {
  type    = string
  default = "10.0.2.0/24"

}

variable "zone_a_c" {

  default = "us-east-1a"

}


variable "zone_b_c" {

  default = "us-east-1b"

}





variable "sg_name_c" {

  default = "sg_lb_vault"

}

variable "sg_description_c" {

  default = "sg for vault lb"

}



variable "sg_tagname_c" {

  default = "sg_lb_vault"

}




variable "sg_ws_name_c" {

  default = "sg_ws_vault"

}

variable "sg_ws_description_c" {

  default = "sg for vault web server"

}



variable "sg_ws_tagname_c" {

  default = "ws_sg_lb_vault"

}

variable "ami_c" {

  default = "ami-08c40ec9ead489470"

}

variable "ami_linux_c" {

  default = "ami-08c40ec9ead489471"

}


variable "instance_type_c" {

  default = "t2.medium"

}

variable "key_pair_c" {

  default = "vault_terra_1"

}




