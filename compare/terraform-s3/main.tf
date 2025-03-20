variable name {
  type        = string
  description = "seu nome"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "${var.name}-terraform-state"
  acl           = "private"
  force_destroy = true
  versioning {
    enabled = false
  }
}

output name {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "Nome do bucket"
}
