resource "aws_s3_bucket" "kops-state" {
  bucket = "irene-terraform"
  acl    = "private"
  force_destroy = true

  versioning {
    enabled = true
  }
}