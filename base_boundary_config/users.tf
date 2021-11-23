## need to add auth0 account to boundary admin user


resource "boundary_user" "kelly" {
  count = var.enable_oidc ? 1 : 0
  name        = "kelly"
  description = "OIDC globally scoped admin user kelly"
  account_ids = [boundary_account_oidc.kelly[0].id]
  scope_id    = boundary_scope.global.id
}


resource "boundary_user" "dave" {
  count = var.enable_oidc ? 1 : 0
  name        = "dave"
  description = "OIDC globally scoped admin user dave"
  account_ids = [
  boundary_account_oidc.dave[0].id]
  scope_id = boundary_scope.global.id
}

resource "boundary_user" "zues" {
  name        = "zues"
  description = "password account for zues"
  account_ids = [
  boundary_account_password.zues.id]
  scope_id = boundary_scope.global.id
}

resource "boundary_user" "hermes" {
  name        = "hermes"
  description = "password account for hermes"
  account_ids = [
  boundary_account_password.hermes.id]
  scope_id = boundary_scope.global.id
}

resource "boundary_user" "hera" {
  name        = "hera"
  description = "password account for hera"
  account_ids = []
  scope_id = boundary_scope.global.id
}

resource "boundary_user" "ares" {
  name        = "ares"
  description = "password account for ares"
  account_ids = []
  scope_id = boundary_scope.global.id
}

resource "boundary_user" "backend" {
  for_each    = var.backend_team
  name        = each.key
  description = "Backend user: ${each.key}"
  account_ids = [boundary_account_password.backend_user_acct[each.value].id]
  scope_id    = boundary_scope.dev.id
}

resource "boundary_user" "frontend" {
  for_each    = var.frontend_team
  name        = each.key
  description = "Frontend user: ${each.key}"
  account_ids = [boundary_account_password.frontend_user_acct[each.value].id]
  scope_id    = boundary_scope.dev.id
}

resource "boundary_user" "leadership" {
  for_each    = var.leadership_team
  name        = each.key
  description = "WARNING: Managers should be read-only"
  account_ids = [boundary_account_password.leadership_user_acct[each.value].id]
  scope_id    = boundary_scope.dev.id
}