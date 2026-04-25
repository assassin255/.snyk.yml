# Root Terraform module for Terminal Sharing Infrastructure
# This module is currently a placeholder to satisfy Spacelift CI requirements.

terraform {
  required_version = ">= 1.0.0"
}

resource "null_resource" "placeholder" {
  triggers = {
    repo_initialized = "true"
  }
}
