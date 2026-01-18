from pyspark.sql.types import StructType, StructField, StringType, DateType

customers_schema = StructType([
    StructField("customer_id", StringType(), nullable=False),
    StructField("first_name", StringType(), nullable=True),
    StructField("last_name", StringType(), nullable=True),
    StructField("email", StringType(), nullable=True),
    StructField("country", StringType(), nullable=True),
    StructField("signup_date", DateType(), nullable=True)
])
