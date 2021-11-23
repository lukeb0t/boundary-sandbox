provider "vault" {
  address    = "http://localhost:8201"
  token      = "root"
  token_name = "root"
}

provider "boundary" {
  addr             = "http://localhost:9200"
  recovery_kms_hcl = <<EOT
kms "aead" {
  purpose = "recovery"
  aead_type = "aes-gcm"
  key = "nIRSASgoP91KmaEcg/EAaM4iAkksyB+Lkes0gzrLIRM="
  key_id = "global_recovery"
}
EOT
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

module "base_boundary" {
source = "./base_boundary_config"
oidc_issuer        = var.oidc_issuer
oidc_client_secret = var.oidc_client_secret
oidc_client_id     = var.oidc_client_id
oidc_subject2      = var.oidc_subject2
oidc_subject1      = var.oidc_subject1
enable_oidc = true
}

module "northwind" {
  source = "./vault-northwinds-module"
  project_id = module.base_boundary.infr_project_id
}