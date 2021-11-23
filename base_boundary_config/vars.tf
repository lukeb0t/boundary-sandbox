variable "url" {
  default = "http://127.0.0.1:9200"
}

variable "oidc_subject2" {
  description = "oidc subject string for global admin"
  default     = null
}
variable "oidc_subject1" {
  description = "oidc subject string for dev org admin"
  default     = null
}

variable "enable_oidc" {
  default = false
}

variable "backend_team" {
  type = set(string)
  default = [
    "jim",
    "mike",
    "todd",
  ]
}

variable "frontend_team" {
  type = set(string)
  default = [
    "randy",
    "susmitha",
  ]
}

variable "leadership_team" {
  type = set(string)
  default = [
    "jeff",
    "pete",
    "jonathan",
    "malnick"
  ]
}

variable "target_ips" {
  type    = set(string)
  default = ["192.168.1.10"]
}

variable "kms_recovery_key_id" {
  default = null
}

variable "oidc_client_id" {
  description = "oidc provider client ID"
  sensitive   = true
  default     = null
}

variable "oidc_client_secret" {
  description = "oidc provider client secret"
  sensitive   = true
  default     = null
}

variable "oidc_issuer" {
  description = "oidc provider issuer URL"
  default     = null
}

variable "api_url_prefix" {
  description = "oidc url prefix"
  default     = "http://localhost:9200"
}

variable "callback_url" {
  description = "oidc callback url address"
  default     = "http://localhost:9200/v1/auth-methods/oidc:authenticate:callback"
}