# Terraform configuration for Spacelift
# This file serves as the entry point for Terraform-based CI/CD.

terraform {
  required_version = ">= 1.0.0"
}

# Add a null resource to allow the module to be initialized and validated
resource "null_resource" "init" {
  triggers = {
    version = "1.0.0"
  }
}
