resource "boundary_group" "leadership" {
  name        = "leadership_team"
  description = "Organization group for leadership team"
  member_ids  = [for user in boundary_user.leadership : user.id]
  scope_id    = boundary_scope.dev.id
}

resource "boundary_group" "backend_core_infra" {
  name        = "backend"
  description = "Backend team group"
  member_ids  = [for user in boundary_user.backend : user.id]
  scope_id    = boundary_scope.core_infra_proj.id
}

resource "boundary_group" "frontend_core_infra" {
  name        = "frontend"
  description = "Frontend team group"
  member_ids  = [for user in boundary_user.frontend : user.id]
  scope_id    = boundary_scope.core_infra_proj.id
}

resource "boundary_group" "global_admins" {
  name        = "global_admins"
  description = "group for global admins"
  member_ids  = compact([boundary_user.zues.id,
  var.enable_oidc ? boundary_user.dave[0].id : null])
  scope_id    = boundary_scope.global.id
}

resource "boundary_group" "dev_admins" {
  name        = "dev_admin"
  description = "group for dev org admins"
  member_ids  = compact([boundary_user.hermes.id,
   var.enable_oidc ? boundary_user.kelly[0].id : null])
  scope_id    = boundary_scope.dev.id
}
