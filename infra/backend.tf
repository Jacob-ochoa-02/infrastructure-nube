terraform {
  backend "s3" {
    bucket       = "poli-terraform"
    key          = "jol/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
