terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
  token = "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"
}