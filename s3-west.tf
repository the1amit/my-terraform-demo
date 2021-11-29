#Provider from diffrent region
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

resource "aws_s3_bucket" "example" {
  provider = aws.west
  bucket   = "example-of-alternate-provider"
  acl      = "private"
}
