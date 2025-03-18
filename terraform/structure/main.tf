resource "aws_s3_bucket" "terraform_state" {
    bucket = "dietcontrol-terraform-state"
    acl = "private"
    force_destroy = true
    versioning {
        enabled = false
    }
}
