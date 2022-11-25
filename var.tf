variable "vpc_cidr_r" {
  type    = string
  default = "11.0.0.0/16"

}


variable "vpc_name_r" {

  default = "vault_vpc"

}

variable "pub_sub1_cidr_block_r" {
  type    = string
  default = "11.0.101.0/24"

}



variable "pub_sub2_cidr_block_r" {
  type    = string
  default = "11.0.102.0/24"

}


variable "prv_sub1_cidr_block_r" {
  type    = string
  default = "11.0.1.0/24"

}


variable "prv_sub2_cidr_block_r" {
  type    = string
  default = "11.0.2.0/24"

}



variable "zone_a_r" {

  default = "us-east-2a"

}

variable "zone_b_r" {

  default = "us-east-2b"

}





variable "sg_name_r" {

  default = "sg_lb_vault"

}

variable "sg_description_r" {

  default = "sg for vault lb"

}



variable "sg_tagname_r" {

  default = "sg_lb_vault"

}




variable "sg_ws_name_r" {

  default = "sg_ws_vault"

}

variable "sg_ws_description_r" {

  default = "sg for vault web server"

}



variable "sg_ws_tagname_r" {

  default = "ws_sg_lb_vault"

}


variable "policy-name-r" {
  default = "vault-policy-south"
}

variable "iam-role-r" {
  default = "vault-role-ap-south"
}



variable "ami_r" {

  default = "ami-097a2df4ac947655f"

}



variable "ami_linux_r" {

  default = "ami-03f4fa076d2981b45"

}




variable "instance_type_r" {

  default = "t2.medium"

}

variable "key_pair_r" {

  default = "ohio_vault"

}


variable "kms_alias_r" {

  default = "alias/vault-kms_auto"

}



variable "kms_tag_r" {

  default = "vault_unseal"

}
