resource "aws_iam_policy" "vault-automation" {
  name        = var.policy-name-c
  description = "vault-kms"
  path        = "/"

  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1668640727509",
      "Action": "kms",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
   )
}



resource "aws_iam_role" "vault-automation" {
  name        = var.iam-role-c
  description = "vault-kms"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "kms" 
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "vault-automation" {
  role       = aws_iam_role.vault-automation.name
  policy_arn = aws_iam_policy.vault-automation.arn
}

