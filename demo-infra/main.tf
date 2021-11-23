provider "vault" {
  address    = module.demo-infra.vault_addr
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

resource "docker_image" "vault" {
  name = "hashicorp/vault:latest"
}

resource "docker_image" "psql" {
  name = "postgres"
}

resource "docker_image" "boundary" {
  name = "hashicorp/boundary"
}

resource "docker_network" "network" {
  name = "boundary_net"
  check_duplicate= true
}
resource "docker_container" "vault" {
  name       = var.vault_hostname
  hostname   = var.vault_hostname
  networks   = [docker_network.network.name]
  image      = docker_image.vault.latest
  privileged = true
  env = ["VAULT_ADDR=http://127.0.0.1:8200",
  "VAULT_TOKEN=root", "VAULT_DEV_ROOT_TOKEN_ID=root"]
  ports {
    internal = 8200
    external = var.vault_host_port
  }
}

resource "docker_container" "psql" {
  name     = "boundary_psql"
  hostname = "boundary_psql"
  networks = [docker_network.network.name]
  image    = docker_image.psql.latest
  env      = ["POSTGRES_PASSWORD=postgres", "POSTGRES_USER=postgres"]
  ports {
    internal = 5432
    external = var.psql_host_port
  }
  provisioner "local-exec" {
    command = <<EOT
  sleep 3
  pwd
  psql "postgresql://postgres:postgres@localhost:${var.psql_host_port}/postgres" -c 'create database boundary_clean'
  psql "postgresql://postgres:postgres@localhost:${var.psql_host_port}/postgres" -c 'create database northwind'
  psql "postgresql://postgres:postgres@localhost:${var.psql_host_port}/northwind" -f northwind-database.sql --quiet
  psql "postgresql://postgres:postgres@localhost:${var.psql_host_port}/northwind" -f northwind-roles.sql --quiet
  EOT
  }
}

resource "docker_container" "boundary_init" {
  name       = "boundary_init"
  hostname   = "boundary_init"
  networks   = [docker_network.network.name]
  privileged = true
  image      = docker_image.boundary.latest
  env        = ["BOUNDARY_POSTGRES_URL=postgresql://postgres:postgres@boundary_psql:${var.psql_host_port}/boundary_clean?sslmode=disable"]
  command    = ["database", "init", "-skip-initial-login-role-creation", "-config", "boundary/config.hcl"]
  depends_on = [
    docker_container.psql
  ]
  provisioner "local-exec" {
    command = "sleep 3"
  }
}

resource "docker_container" "boundary_serv" {
  name       = "boundary_serv"
  hostname   = "boundary_serv"
  networks   = [docker_network.network.name]
  privileged = true
  image      = docker_image.boundary.latest
  env        = ["BOUNDARY_POSTGRES_URL=postgresql://postgres:postgres@boundary_psql/boundary_clean?sslmode=disable"]

  ports {
    internal = 9200
    external = var.boundary_host_api_port
  }
  ports {
    internal = 9201
    external = var.boundary_host_cluster_port
  }
  ports {
    internal = 9202
    external = 9202
  }
   
  depends_on = [
    docker_container.boundary_init
  ]
}
