terraform {
  required_providers {
    boundary = {
      source  = "hashicorp/boundary"
      version = "1.0.5"
    }
  vault  = {
    source = "hashicorp/vault"
  }
  }
}