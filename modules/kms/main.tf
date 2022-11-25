data "aws_iam_policy_document" "kms" {

  statement {
    sid       = "Allow KMS Use"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::273406663879:root"
      ]
    }

  }
}








resource "aws_kms_key" "primary" {
  description         = "creating aws kms key for vault unseal"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.kms.json
  

  tags = {
    Name = var.kms_tag_c
  }
}


resource "aws_kms_alias" "primary" {
  name          = "alias/vault-kms"
  target_key_id = aws_kms_key.primary.key_id
}


