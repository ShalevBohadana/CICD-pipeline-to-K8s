// infra/iam-provisioning.tf

data "aws_iam_policy_document" "terraform_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
      # or the OIDC principal for your CI system
    }
  }
}

resource "aws_iam_role" "terraform_infra" {
  name               = "TerraformInfraRole"
  assume_role_policy = data.aws_iam_policy_document.terraform_assume.json
}

resource "aws_iam_role_policy_attachment" "eks_readonly" {
  role       = aws_iam_role.terraform_infra.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSReadOnlyAccess"
}

# (Optional) S3 & DynamoDB policies for state
resource "aws_iam_role_policy_attachment" "s3_full" {
  role       = aws_iam_role.terraform_infra.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
resource "aws_iam_role_policy_attachment" "dynamodb_full" {
  role       = aws_iam_role.terraform_infra.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_instance_profile" "terraform_infra" {
  name = "TerraformInfraInstanceProfile"
  role = aws_iam_role.terraform_infra.name
}
