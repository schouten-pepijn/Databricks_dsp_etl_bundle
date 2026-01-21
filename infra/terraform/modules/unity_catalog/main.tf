# Catalog
resource "databricks_catalog" "main" {
    name = var.catalog_name
    comment = "UC Catalog owned by Terraform"
}

# Schema
resource "databricks_schema" "main" {
    catalog_name = databricks_catalog.main.name
    name = var.schema_name
    comment = "Schema for Medallion ETL"
}

# Raw/Landing Volumne
resource "databricks_volume" "raw_landing" {
    name = var.raw_volume_name
    schema_name = databricks_schema.main.name
    catalog_name = databricks_catalog.main.name
    volume_type = var.volume_type
    comment = "Raw landing volume for Medallion ETL"
}

# Checkpoints Volumne
resource "databricks_volume" "checkpoints" {
    name = var.checkpoint_volume_name
    schema_name = databricks_schema.main.name
    catalog_name = databricks_catalog.main.name
    volume_type = var.volume_type
    comment = "Checkpoints volume for Medallion ETL"
}

# Grants: Owner Group is OWNER on everything
resource "databricks_grants" "catalog" {
  catalog = databricks_catalog.main.name

  grant {
    principal  = var.owner_group
    permission = "OWNER"
  }
}

resource "databricks_grants" "schema" {
  schema = "${databricks_catalog.main.name}.${databricks_schema.main.name}"

  grant {
    principal  = var.owner_group
    permission = "OWNER"
  }
}

resource "databricks_grants" "raw_landing" {
  volume = databricks_volume.raw_landing.full_name

  grant {
    principal  = var.owner_group
    permission = "OWNER"
  }
}

resource "databricks_grants" "checkpoints" {
  volume = databricks_volume.checkpoints.full_name

  grant {
    principal  = var.owner_group
    permission = "OWNER"
  }
}