# Airbnb Clone Backend - SQL Queries

Welcome to the repository! This project focuses on implementing and understanding various SQL queries for the Airbnb Clone backend. The following sections include SQL queries for different tasks such as joins, subqueries, data analysis, and aggregations, with detailed comments explaining their usage and functionality.

---

## Table of Contents

1. [SQL Queries for Joins](#sql-queries-for-joins)
2. [SQL Queries for Correlated and Non-Correlated Subqueries](#sql-queries-for-correlated-and-non-correlated-subqueries)
3. [SQL Data Analysis with Aggregation and Window Functions](#sql-data-analysis-with-aggregation-and-window-functions)

---

## SQL Queries for Joins

This section demonstrates how to retrieve data from the database using different types of SQL joins, including **INNER JOIN**, **LEFT JOIN**, and **FULL OUTER JOIN**.

### 1. **INNER JOIN**: Retrieve all bookings and the respective users who made those bookings

This query joins the `Bookings` table with the `Users` table to get the booking details along with the user information (first name, last name, email) of the person who made the booking. Only bookings that have associated users are included in the result.

```sql
-- INNER JOIN: Retrieve all bookings and the respective users who made those bookings
SELECT 
    b.booking_id,  -- Booking ID
    b.property_id, -- Property ID
    b.start_date,  -- Start date of the booking
    b.end_date,    -- End date of the booking
    b.total_price, -- Total price of the booking
    u.first_name,  -- First name of the user who made the booking
    u.last_name,   -- Last name of the user who made the booking
    u.email        -- Email of the user who made the booking
FROM 
    Bookings b
INNER JOIN 
    Users u ON b.user_id = u.user_id;  -- Join on user_id to get the respective user
```

### 2. **LEFT JOIN**: Retrieve all properties and their reviews, including properties that have no reviews

A `LEFT JOIN` is used here to get all the properties, including those that may not have any reviews. If no reviews are available, the review columns will contain `NULL` values for those properties.

```sql
-- LEFT JOIN: Retrieve all properties and their reviews, including properties with no reviews
SELECT 
    p.property_id,
    p.name AS property_name,
    r.review_id,
    r.rating,
    r.comment
FROM 
    Property p
LEFT JOIN 
    Review r  -- Join on property_id to include reviews, even if no reviews exist
ON 
    p.property_id = r.property_id
ORDER BY 
    p.name;  -- Ordering the results by property name
```

### 3. **FULL OUTER JOIN**: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user

This query uses a `FULL OUTER JOIN` to ensure that all users and all bookings are included in the result. It will show users who haven't made any bookings and bookings that are not associated with a user.

```sql
-- FULL OUTER JOIN: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
SELECT 
    u.user_id,         -- User ID
    u.first_name,      -- First name of the user
    u.last_name,       -- Last name of the user
    u.email,           -- Email of the user
    b.booking_id,      -- Booking ID (if any)
    b.property_id,     -- Property ID (if any)
    b.start_date,      -- Start date of the booking (if any)
    b.end_date,        -- End date of the booking (if any)
    b.total_price      -- Total price of the booking (if any)
FROM 
    Users u
FULL OUTER JOIN 
    Bookings b ON u.user_id = b.user_id;  -- Join on user_id to include users with no bookings and bookings with no users
```

---

## SQL Queries for Correlated and Non-Correlated Subqueries

This section demonstrates how to use **correlated** and **non-correlated subqueries** in SQL queries.

### 1. **Non-Correlated Subquery**: Find Properties with Average Rating > 4.0

This query retrieves properties that have an **average rating** greater than **4.0**. It uses a **non-correlated subquery**, meaning the subquery is independent of the outer query.

```sql
-- Retrieve all properties where the average rating is greater than 4.0
SELECT 
    p.property_id,
    p.name AS property_name
FROM 
    Property p
WHERE 
    -- Subquery calculates the average rating for each property
    (SELECT AVG(r.rating) 
     FROM Review r 
     WHERE r.property_id = p.property_id) > 4.0;
```

### 2. **Correlated Subquery**: Find Users with More Than 3 Bookings

This query identifies **users** who have made **more than 3 bookings**. It uses a **correlated subquery**, where the subquery depends on values from the outer query.

```sql
-- Find users who have made more than 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name
FROM 
    User u
WHERE 
    -- Subquery counts the number of bookings made by each user
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.user_id = u.user_id) > 3;
```

---

## SQL Data Analysis with Aggregation and Window Functions

This section contains SQL queries that demonstrate how to analyze data using **aggregation functions** (like `COUNT`) and **window functions** (like `ROW_NUMBER` and `RANK`).

### Query 1: Total Number of Bookings per User

This query calculates the total number of bookings made by each user in the system. It uses the `COUNT` function to aggregate the number of bookings for each user.

```sql
-- Total number of bookings per user
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name
ORDER BY 
    total_bookings DESC;
```

### Query 2: Ranking Properties by Bookings

This query ranks properties based on the total number of bookings using **window functions**:
- **`ROW_NUMBER`**: Assigns a unique rank to each property, even if there are ties in booking count.
- **`RANK`**: Assigns the same rank to properties with identical booking counts.

```sql
-- Ranking properties by the total number of bookings
SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_num,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name
ORDER BY 
    rank;
```

---

## Conclusion

This repository provides a series of SQL queries to demonstrate various important SQL operations:
- **Joins**: `INNER JOIN`, `LEFT JOIN`, and `FULL OUTER JOIN` are used to retrieve and combine data from different tables.
- **Subqueries**: Both correlated and non-correlated subqueries are employed for complex filtering and comparisons.
- **Aggregation and Window Functions**: Aggregation functions like `COUNT` and window functions like `ROW_NUMBER` and `RANK` are applied for data analysis and ranking.

These queries can help in extracting valuable insights from the database for the Airbnb Clone backend. To run these queries, make sure your database has the required tables (`Users`, `Bookings`, `Properties`, `Reviews`, `Payments`) and that the data is populated accordingly.



