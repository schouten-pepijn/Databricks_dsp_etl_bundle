variable "databricks_host" {
  type        = string
  description = "Databricks workspace URL (vb. https://dbc-xxx.cloud.databricks.com)"
}

variable "databricks_token" {
  type        = string
  sensitive   = true
  description = "Databricks PAT token"
}

variable "catalog_name" {
  type        = string
  default     = "workspace"
  description = "UC catalog name"
}

variable "schema_name" {
  type        = string
  default     = "etl_demo"
  description = "UC schema name"
}

variable "owner_group_name" {
  type        = string
  default     = "etl_team"
  description = "Owner group name"
}