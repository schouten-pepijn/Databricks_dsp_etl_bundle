from pyspark import pipelines as dp
from pyspark.sql.functions import count

@dp.materialized_view(name="gold_customer_counts")
def gold_customer_counts():
    silver = spark.table("silver_customers")
    return silver.groupBy("country").agg(count("*").alias("cust_count"))
