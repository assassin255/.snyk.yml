# Root Terraform module
terraform {
  required_version = ">= 1.0.0"
}

resource "null_resource" "init" {
  triggers = {
    initialized = "true"
  }
}
