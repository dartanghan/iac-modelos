resource "aws_s3_bucket" "terraform_state" {
    bucket = "dart-terraform-state"
    acl = "private"
    force_destroy = true
    versioning {
        enabled = false
    }
}
