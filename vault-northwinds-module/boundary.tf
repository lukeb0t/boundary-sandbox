resource "boundary_host_catalog" "host_cat" {
  name        = "psql host cat"
  description = "catalog for the northwins database servers"
  scope_id    = var.project_id
  type        = "static"
}

resource "boundary_host" "psql" {
  name            = "docker-psql"
  description     = "psql northwinds database"
  address         = "boundary_psql"
  type            = "static"
  host_catalog_id = boundary_host_catalog.host_cat.id
}

resource "boundary_host_set" "psql" {
  name            = "psql_hosts"
  description     = "host set for psql northwind servers"
  host_catalog_id = boundary_host_catalog.host_cat.id
  type            = "static"
  host_ids        = [boundary_host.psql.id]
}

resource "boundary_credential_store_vault" "creds_store" {
  name        = "infra_creds_store"
  description = "credential store for the infrastructure project"
  scope_id    = var.project_id
  address     = "http://${var.vault_hostname}:${var.vault_port}"
  token       = vault_token.boundary.client_token
}

resource "boundary_credential_library_vault" "northwind_dba" {
  name                = "northwind_dba"
  description         = "creds library for the northwinds dbas"
  credential_store_id = boundary_credential_store_vault.creds_store.id
  path                = "psql/creds/dba"
}
resource "boundary_credential_library_vault" "northwind_analyst" {
  name                = "northwind_analyst"
  description         = "creds library for the northwinds db analysts"
  credential_store_id = boundary_credential_store_vault.creds_store.id
  path                = "psql/creds/analyst"
}
resource "boundary_target" "psql_dba" {
  name         = "psql_dbas"
  description  = "northwinds database targetfor dbas"
  type         = "tcp"
  default_port = var.psql_port
  scope_id     = var.project_id
  host_source_ids = [
    boundary_host_set.psql.id
  ]
  application_credential_source_ids = [
    boundary_credential_library_vault.northwind_dba.id
  ]
}

resource "boundary_target" "psql_analysts" {
  name         = "psql_analysts"
  description  = "northwinds database target for analysts"
  type         = "tcp"
  default_port = var.psql_port
  scope_id     = var.project_id
  host_source_ids = [
    boundary_host_set.psql.id
  ]
  application_credential_source_ids = [
    boundary_credential_library_vault.northwind_analyst.id
  ]
}

