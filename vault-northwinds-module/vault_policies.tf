resource "vault_policy" "controller_policy" {
  name   = "boundary_controller_policy"
  policy = <<EOT
  path "auth/token/lookup-self" {
  capabilities = ["read"]
}

path "auth/token/renew-self" {
  capabilities = ["update"]
}

path "auth/token/revoke-self" {
  capabilities = ["update"]
}

path "sys/leases/renew" {
  capabilities = ["update"]
}

path "sys/leases/revoke" {
  capabilities = ["update"]
}

path "sys/capabilities-self" {
  capabilities = ["update"]
}
EOT
}

resource "vault_policy" "northwind_db_policy" {
  name   = "northwind_db_policy"
  policy = <<EOT
path "database/creds/analyst" {
  capabilities = ["read"]
}

path "database/creds/dba" {
  capabilities = ["read"]
}
EOT
}

resource "vault_token" "boundary" {
  policies          = [vault_policy.northwind_db_policy.name, vault_policy.controller_policy.name]
  renewable         = true
  no_parent         = true
  period            = "20m"
  no_default_policy = true
}