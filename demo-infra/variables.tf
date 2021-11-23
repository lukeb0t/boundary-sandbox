variable "psql_port" {
  default     = 5432
  description = "port the vault and boundary servers will use to connect to the psql server"
}

variable "psql_service_accnt" {
  default     = "postgres"
  description = "service account for vault to connect to the psql server"
}

variable "psql_serv_accnt_pw" {
  default     = "postgres"
  description = "service account password for vault to connect to the psql server"
}
variable "psql_hostname" {
  default     = "boundary_psql"
  description = "ip or hostname of the psql server"
}

variable "root_db" {
  default     = "postgres"
  description = "the master db of the psql server for the vault connection"
}

variable "vault_hostname" {
  default     = "hcvault1"
  description = "ip or hostname of the vault server"
}

variable "vault_port" {
  default     = 8200
  description = "the configured local port to connect to the vault server"
}

variable "vault_host_port" {
  default = 8201
  description = "the configured host port to connect to the vault server"
}

variable "boundary_host_api_port" {
  default = 9200
  description = "the configured host port to connect to the boundary controller" 
}

variable "boundary_host_cluster_port" {
  default = 9201
  description = "the configured host port to connect to the boundary controller" 
}

variable "psql_host_port" {
  default = 5432
  description = "the configured host port to connect to the psql service"
}