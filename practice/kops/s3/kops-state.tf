resource "aws_s3_bucket" "kops-state" {
  bucket = "irene-terraform"
  acl    = "private"

  versioning {
    enabled = true
  }
}