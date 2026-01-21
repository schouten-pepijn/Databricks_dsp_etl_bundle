output "catalog_name" {
  value       = databricks_catalog.main.name
  description = "Catalog name"
}

output "schema_name" {
  value       = databricks_schema.main.name
  description = "Schema name"
}

output "raw_landing_path" {
  value       = local.raw_landing_path
  description = "Full UC path to raw landing volume"
}

output "checkpoints_path" {
  value       = local.checkpoints_path
  description = "Full UC path to checkpoints volume"
}

output "catalog_full_name" {
  value       = "${databricks_catalog.main.name}"
  description = "Catalog name (for grants and refs)"
}

output "schema_full_name" {
  value       = "${databricks_catalog.main.name}.${databricks_schema.main.name}"
  description = "Full schema path (catalog.schema)"
}