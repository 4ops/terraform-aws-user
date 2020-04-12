terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = ">= 2.50"
  }
}

provider aws {
  region = var.region
}

module test {
  source = "../"

  name = "testing-terraform-module"
  tags = {
    Module    = "user",
    Terraform = "true",
    Testing   = "true",
  }
}
