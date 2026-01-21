locals {
  raw_landing_path = "/Volumes/${databricks_catalog.main.name}/${databricks_schema.main.name}/${databricks_volume.raw_landing.name}"
  checkpoints_path = "/Volumes/${databricks_catalog.main.name}/${databricks_schema.main.name}/${databricks_volume.checkpoints.name}"
}