from pyspark import pipelines as dp
from pyspark.sql.functions import col, trim, row_number, lit
from pyspark.sql.window import Window

@dp.materialized_view(name="silver_erros")
def silver_errors():
    df = spark.table("bronze_customers")

    col_name = "customer_id"
    is_missing = (
        col(col_name).isNull() |
       (trim(col(col_name)) == "")
    )

    return (
        df
        .filter(is_missing)
        .select(
            col("customer_id"),
            col("first_name"),
            col("last_name"),
            col("email"),
            col("country"),
            col("signup_date"),
            col("_source_file"),
            lit("missing_customer_id").alias("error_reason")
        )
    )