output "vault_addr" {
    value = "http://localhost:${var.vault_host_port}"
}

output "boundary_addr" {
    value = "http://localhost:${var.boundary_host_api_port}"
}

output "psql_connection_string" {
    value = "postgresql://postgres:postgres@boundary_psql:${var.psql_host_port}/postgres?sslmode=disable"
}