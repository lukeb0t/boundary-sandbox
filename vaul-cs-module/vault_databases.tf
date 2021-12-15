resource "vault_mount" "psql" {
  path = "psql"
  type = "database"
}

resource "vault_database_secret_backend_connection" "northwind_connection" {
  backend       = vault_mount.psql.path
  name          = "postgres"
  allowed_roles = ["dba", "analyst"]

  postgresql {
    connection_url = "postgresql://${var.psql_service_accnt}:${var.psql_serv_accnt_pw}@${var.psql_hostname}:${var.psql_port}/${var.root_db}?sslmode=disable"
  }
}

