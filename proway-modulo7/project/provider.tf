provider "aws" {
    region = var.project_region
}

locals {
    bucket_name = "${var.project_name}-terraform-state"
}

terraform {
    backend "s3" {
        bucket = local.bucket_name
        key    = "terraform.tfstate"
        region = "us-west-1"
    }
}