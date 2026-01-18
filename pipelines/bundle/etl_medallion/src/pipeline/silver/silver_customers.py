from pyspark import pipelines as dp
from pyspark.sql.functions import col, trim, row_number
from pyspark.sql.window import Window

@dp.materialized_view(name="silver_customers")
@dp.expect_or_drop(
    "valid_customer_id",
    "customer_id IS NOT NULL AND trim(customer_id) != ''"
)
def silver_customers():
    df = spark.table("bronze_customers")

    w = (
        Window
        .partitionBy("customer_id")
        .orderBy(
            col("_source_file")
            .desc()
        )
    )

    deduped = (
        df
        .withColumn("_rn", row_number().over(w))
        .filter(col("_rn") == 1)
        .drop("_rn")
    )

    return (
        deduped
        .select(
            col("customer_id"),
            col("first_name"),
            col("last_name"),
            col("email"),
            col("country"),
            col("signup_date"),
            col("_source_file")
        )
    )
