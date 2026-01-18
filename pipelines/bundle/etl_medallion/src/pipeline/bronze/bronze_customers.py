from pyspark import pipelines as dp
from pyspark.sql.functions import col

from pipeline.utils.schemas import customers_schema

bronze_customers_schema_location = spark.conf.get(
    "BRONZE_CUSTOMERS_SCHEMA_LOCATION"
)
raw_customer_path = spark.conf.get(
    "RAW_CUSTOMER_PATH"
)

@dp.table(name="bronze_customers")
def bronze_customers():
    return (
        spark.readStream
            .format("cloudFiles")
            .option("cloudFiles.format", "json")
            .option(
                "cloudFiles.schemaLocation", bronze_customers_schema_location
            )
            .schema(customers_schema)
            .load(raw_customer_path)
            .withColumn("_source_file", col("_metadata.file_path"))
    )