output "catalog_name" {
  value = databricks_catalog.main.name
}

output "schema_name" {
  value = databricks_schema.main.name
}

output "raw_landing_path" {
  value = local.raw_landing_path
}

output "checkpoints_path" {
  value = local.checkpoints_path
}