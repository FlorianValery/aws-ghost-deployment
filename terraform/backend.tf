terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = ""
    key     = ""
  }
}