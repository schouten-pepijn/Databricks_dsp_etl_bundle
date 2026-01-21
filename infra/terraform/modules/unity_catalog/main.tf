resource "databricks_catalog" "main" {
  name    = var.catalog_name
  comment = "UC Catalog managed by Terraform"
}

resource "databricks_schema" "main" {
  catalog_name = databricks_catalog.main.name
  name         = var.schema_name
  comment      = "Schema for ETL"
}

resource "databricks_volume" "raw_landing" {
  catalog_name = databricks_catalog.main.name
  schema_name  = databricks_schema.main.name
  name         = var.raw_volume_name
  volume_type  = var.volume_type
  comment      = "Raw/landing data volume"
}

resource "databricks_volume" "checkpoints" {
  catalog_name = databricks_catalog.main.name
  schema_name  = databricks_schema.main.name
  name         = var.checkpoint_volume_name
  volume_type  = var.volume_type
  comment      = "Streaming checkpoints volume"
}

# Grants for owner group
resource "databricks_grants" "catalog" {
  catalog = databricks_catalog.main.name

  grant {
    principal  = var.owner_group
    privileges = ["OWN"]
  }
}

resource "databricks_grants" "schema" {
  schema = "${databricks_catalog.main.name}.${databricks_schema.main.name}"

  grant {
    principal  = var.owner_group
    privileges = ["OWN"]
  }
}

resource "databricks_grants" "raw_landing" {
  volume = "${databricks_catalog.main.name}.${databricks_schema.main.name}.${databricks_volume.raw_landing.name}"

  grant {
    principal  = var.owner_group
    privileges = ["OWN"]
  }
}

resource "databricks_grants" "checkpoints" {
  volume = "${databricks_catalog.main.name}.${databricks_schema.main.name}.${databricks_volume.checkpoints.name}"

  grant {
    principal  = var.owner_group
    privileges = ["OWN"]
  }
}