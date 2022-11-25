module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr_c            = var.vpc_cidr_r
  vpc_name_c            = var.vpc_name_r
  pub_sub1_cidr_block_c = var.pub_sub1_cidr_block_r
  pub_sub2_cidr_block_c = var.pub_sub2_cidr_block_r
  prv_sub1_cidr_block_c = var.prv_sub1_cidr_block_r
  prv_sub2_cidr_block_c = var.prv_sub2_cidr_block_r
  sg_name_c             = var.sg_name_r
  sg_tagname_c          = var.sg_tagname_r
  sg_ws_name_c          = var.sg_ws_name_r
  sg_ws_tagname_c       = var.sg_ws_tagname_r
  ami_c                 = var.ami_r
  instance_type_c       = var.instance_type_r
  key_pair_c            = var.key_pair_r
  zone_a_c              = var.zone_a_r
  zone_b_c              = var.zone_b_r

}


module "kms_key" {
  source = "./modules/kms"

  kms_alias_c = var.kms_alias_r
  kms_tag_c   = var.kms_tag_r

}


module "iam_role_kms" {
  source = "./modules/iam"

  policy-name-c = var.policy-name-r
  iam-role-c    = var.iam-role-r

}

