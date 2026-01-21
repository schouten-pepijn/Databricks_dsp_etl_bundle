# Unity Catalog module
module "unity_catalog" {
    source = "../../modules/unity_catalog"

    catalog_name = var.catalog_name
    schema_name  = var.schema_name
    owner_group  = databricks_group.etl_team.display_name
}

# Group for access control
resource "databricks_group" "etl_team" {
    display_name = var.owner_group_name
}

# Output for Bundles
output "bundle_config" {
    value = {
        catalog = module.unity_catalog.catalog_name
        schema  = module.unity_catalog.schema_name
        raw_landing_path = module.unity_catalog.raw_landing_path
        checkpoints_path = module.unity_catalog.checkpoints_path
        owner_group = var.owner_group_name
    }
    description = "UC and Group config for Bundles"
}