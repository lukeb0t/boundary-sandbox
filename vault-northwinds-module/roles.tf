resource "vault_database_secret_backend_role" "analyst_role" {
  backend = vault_mount.psql.path
  name    = "analyst"
  db_name = vault_database_secret_backend_connection.northwind_connection.name
  creation_statements = [
    "create role \"{{name}}\" with login password '{{password}}' valid until '{{expiration}}' inherit;",
  "grant northwind_analyst to \"{{name}}\";"]
}

resource "vault_database_secret_backend_role" "dba_role" {
  backend = vault_mount.psql.path
  name    = "dba"
  db_name = vault_database_secret_backend_connection.northwind_connection.name
  creation_statements = ["create role \"{{name}}\" with login password '{{password}}' valid until '{{expiration}}' inherit;",
  "grant northwind_dba to \"{{name}}\";"]
}

