

resource "boundary_account_password" "backend_user_acct" {
  for_each       = var.backend_team
  name           = each.key
  description    = "User account for ${each.key}"
  type           = "password"
  login_name     = lower(each.key)
  password       = "foofoofoo"
  auth_method_id = boundary_auth_method_password.dev_pass.id
}

resource "boundary_account_password" "frontend_user_acct" {
  for_each       = var.frontend_team
  name           = each.key
  description    = "User account for ${each.key}"
  type           = "password"
  login_name     = lower(each.key)
  password       = "foofoofoo"
  auth_method_id = boundary_auth_method_password.dev_pass.id
}

resource "boundary_account_password" "leadership_user_acct" {
  for_each       = var.leadership_team
  name           = each.key
  description    = "User account for ${each.key}"
  type           = "password"
  login_name     = lower(each.key)
  password       = "foofoofoo"
  auth_method_id = boundary_auth_method_password.dev_pass.id
}
resource "boundary_account_password" "zues" {
  name           = "zues"
  description    = "global admin account"
  login_name     = "zues"
  type           = "password"
  password       = "rootroot"
  auth_method_id = boundary_auth_method_password.global_pass.id
}

resource "boundary_account_password" "hermes" {
  name           = "hermes"
  description    = "globally scoped accounnt for a lesser diety"
  login_name     = "hermes"
  type           = "password"
  password       = "rootroot"
  auth_method_id = boundary_auth_method_password.global_pass.id
}


// organiation level group for the leadership team
