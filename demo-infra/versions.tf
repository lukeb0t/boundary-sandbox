terraform {
  required_providers {
    boundary = {
      source  = "hashicorp/boundary"
      version = "1.0.5"
    }
  docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  vault  = {
    source = "hashicorp/vault"
  }
  }
}