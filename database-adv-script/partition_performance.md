# Partitioning Performance Report for Booking Table

## Objective

The goal of this partitioning implementation is to improve the query performance on large datasets, specifically focusing on the `Bookings` table, which is assumed to be large and queried frequently. Partitioning the table based on the `start_date` column allows queries filtering by date to perform more efficiently by reducing the number of rows scanned.

## Implementation Details

### 1. Partitioned Table Creation

The `Bookings` table is partitioned using the `start_date` column. This partitioning strategy splits the data into separate partitions based on year, which is a common query pattern for bookings. Each partition stores bookings for a single year, which helps optimize queries that filter by date range.

```sql
CREATE TABLE Bookings_partitioned (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status_id UUID NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
PARTITION BY RANGE (start_date);
```

### 2. Creating Partitions for Each Year

Separate partitions are created for each year. For example, the following partitions were created for the years 2022, 2023, and 2024:

```sql
CREATE TABLE Bookings_2022 PARTITION OF Bookings_partitioned
    FOR VALUES FROM ('2022-01-01') TO ('2022-12-31');

CREATE TABLE Bookings_2023 PARTITION OF Bookings_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2023-12-31');

CREATE TABLE Bookings_2024 PARTITION OF Bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-12-31');
```

Additional partitions can be added for future years or specific date ranges as necessary.

### 3. Sample Query for Performance Testing

To assess the performance of queries on the partitioned table, two sample queries were used, along with the `EXPLAIN ANALYZE` command to measure query execution plans and time taken:

```sql
EXPLAIN ANALYZE
SELECT * FROM Bookings_partitioned
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';

EXPLAIN ANALYZE
SELECT * FROM Bookings_partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';
```

The use of `EXPLAIN ANALYZE` helps us understand how the partitioning impacts query performance by providing insights into how the database engine handles the query execution, including the time spent on reading from the partitions.

## Performance Improvements

By partitioning the `Bookings` table based on `start_date`, we achieve several potential performance improvements:

1. **Reduced Data Scanning**: Queries that filter by the `start_date` will only scan the relevant partition(s), significantly reducing the amount of data processed. For example, when querying for bookings in 2023, only the `Bookings_2023` partition will be accessed.

2. **Improved Query Execution Time**: With partition pruning (where the database engine skips irrelevant partitions based on the query's `start_date` filter), query execution time is reduced, especially for large datasets.

3. **Optimized Indexing**: Each partition can be indexed separately, which allows for more efficient querying within a specific date range.

## Conclusion

Partitioning the `Bookings` table by `start_date` offers substantial performance improvements for queries that involve filtering by date range. The partitioning strategy reduces the amount of data the database needs to scan, which leads to faster query execution, especially when dealing with large volumes of data. Additionally, using `EXPLAIN ANALYZE` provides valuable insights into the query performance, helping us confirm the benefits of partitioning.

Future improvements may include adding additional partitions for specific date ranges or adding indexes to further optimize query performance.
```

### Key Takeaways:
- Partitioning helps reduce query time by limiting the dataset being scanned.
- Using `EXPLAIN ANALYZE` is essential for understanding query performance before and after partitioning.
- The report demonstrates how partitioning can drastically improve performance on large datasets.