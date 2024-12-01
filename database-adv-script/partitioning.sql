-- Partitioning Implementation for Booking Table to Improve Performance
-- This SQL file contains the creation of a partitioned Booking table, 
-- followed by the creation of individual partitions based on start_date.

-- 1. Create Partitioned Table
-- Create the main table with all necessary columns, and partition it by start_date.
CREATE TABLE Bookings_partitioned (
    booking_id UUID PRIMARY KEY,                  -- Unique ID for each booking.
    property_id UUID NOT NULL,                    -- Reference to the property being booked.
    user_id UUID NOT NULL,                        -- Reference to the user who made the booking.
    start_date DATE NOT NULL,                     -- Start date used for partitioning.
    end_date DATE NOT NULL,                       -- End date of the booking.
    status_id UUID NOT NULL,                      -- Reference to the booking's status.
    total_price DECIMAL(10, 2) NOT NULL,          -- Total price for the booking.
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp when the booking was created.
)
PARTITION BY RANGE (start_date);  -- Partition the table by the start_date column.

-- 2. Create Partitions for Each Year
-- Create individual partitions for each year. Each partition holds bookings for one year.

CREATE TABLE Bookings_2022 PARTITION OF Bookings_partitioned
    FOR VALUES FROM ('2022-01-01') TO ('2022-12-31'); -- Data for the year 2022.

CREATE TABLE Bookings_2023 PARTITION OF Bookings_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2023-12-31'); -- Data for the year 2023.

CREATE TABLE Bookings_2024 PARTITION OF Bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-12-31'); -- Data for the year 2024.

-- 3. Sample Query for Performance Testing
-- The following queries demonstrate how to fetch data from the partitioned table 
-- and measure performance using EXPLAIN ANALYZE.

EXPLAIN ANALYZE
SELECT * FROM Bookings_partitioned
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';  -- Query for bookings in 2023.

EXPLAIN ANALYZE
SELECT * FROM Bookings_partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';  -- Query for bookings in the first quarter of 2024.
