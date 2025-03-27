resource "aws_s3_bucket" "terraform_state" {
    bucket = "${var.project_name}-terraform-state"
    acl = "private"
    force_destroy = true
    versioning {
        enabled = false
    }
}
