resource "boundary_account_oidc" "kelly" {
  count = var.enable_oidc ? 1 : 0
  auth_method_id = boundary_auth_method_oidc.auth0[0].id
  issuer         = var.oidc_issuer
  name           = "kelly"
  subject        = var.oidc_subject2
}

resource "boundary_account_oidc" "dave" {
  count = var.enable_oidc ? 1 : 0
  auth_method_id = boundary_auth_method_oidc.auth0[0].id
  issuer         = var.oidc_issuer
  name           = "dave"
  subject        = var.oidc_subject1
}