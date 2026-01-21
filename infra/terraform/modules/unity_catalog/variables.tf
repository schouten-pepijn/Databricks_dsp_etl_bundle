variable "catalog_name" {
    type = string
    description = "The name of the Unity Catalog catalog."
}

variable "schema_name" {
    type = string
    description = "The name of the Unity Catalog schema."
}

variable "owner_group" {
    type = string
    description = "The owner group of the Unity Catalog schema."
}

variable "raw_volume_name" {
    type = string
    default = "raw_landing"
    description = "The name of the raw volume in Unity Catalog."
}

variable "checkpoint_volume_name" {
    type = string
    default = "checkpoint"
    description = "The name of the checkpoint volume in Unity Catalog."
}

variable "volume_type" {
    type = string
    default = "MANAGED"
    description = "Volume type for Unity Catalog volumes: MANAGED / EXTERNAL."
}