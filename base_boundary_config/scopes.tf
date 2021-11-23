resource "boundary_scope" "global" {
  global_scope = true
  name         = "global"
  scope_id     = "global"
}

resource "boundary_scope" "dev" {
  scope_id    = boundary_scope.global.id
  name        = "development"
  description = "Development Scope"
}

resource "boundary_scope" "core_infra_proj" {
  name        = "core_infrastructure"
  description = "Backend infrastrcture project"
  scope_id    = boundary_scope.dev.id
}
