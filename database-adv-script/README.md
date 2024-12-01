# Airbnb Clone Backend - SQL Queries for Joins

Welcome to the repository! This project is focused on implementing and understanding different types of SQL joins for the Airbnb Clone backend. Below, you'll find the SQL queries designed to fetch data using various types of joins, along with detailed comments explaining how they work.

## SQL Queries Overview

The following queries demonstrate how to retrieve data from the database using **INNER JOIN**, **LEFT JOIN**, and **FULL OUTER JOIN**:

### 1. **INNER JOIN**: Retrieve all bookings and the respective users who made those bookings.

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

### 2. **LEFT JOIN**: Retrieve all properties and their reviews, including properties that have no reviews.

A `LEFT JOIN` is used here to get all the properties, including those that may not have any reviews. If no reviews are available, the review columns will contain `NULL` values for those properties.

```sql
-- LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews
SELECT 
    p.property_id,     -- Property ID
    p.name AS property_name, -- Property name
    p.location,        -- Property location
    p.pricepernight,   -- Price per night for the property
    r.rating,          -- Rating for the property (if available)
    r.comment          -- Review comment for the property (if available)
FROM 
    Properties p
LEFT JOIN 
    Reviews r ON p.property_id = r.property_id;  -- Join on property_id to include reviews, even if no reviews exist
```

### 3. **FULL OUTER JOIN**: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

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

## How to Use the SQL Queries

These SQL queries are designed to run on the backend database of the Airbnb Clone. They should be executed in a relational database system like MySQL or PostgreSQL to fetch data. The queries help fetch detailed information about bookings, users, properties, and reviews, which can be essential for building the Airbnb Clone features like user profiles, property details, and booking management.

### Requirements:
1. A relational database (PostgreSQL, MySQL, etc.) with the following tables:
   - `Users`
   - `Bookings`
   - `Properties`
   - `Reviews`
2. Data populated into the tables as per the schema.

### Running the Queries:
1. Set up your database with the required tables and relationships.
2. Execute the queries one by one using your database management system (e.g., pgAdmin, MySQL Workbench, or a similar tool).
3. Review the results to ensure that the data is retrieved correctly based on the type of join.

## Why These Joins Are Important

- **INNER JOIN**: Used when we only want to see the records that have related data in both tables. This is great for fetching data that must be linked.
  
- **LEFT JOIN**: Useful when we want to include records from the left table even if there's no corresponding match in the right table. This is helpful when we want to see everything (e.g., all properties) but also consider records with missing data (e.g., properties without reviews).
  
- **FULL OUTER JOIN**: Provides a full picture, including all records from both tables, whether they match or not. This is useful when we want to see all users and all bookings, even if some users haven't made any bookings or bookings don't have users linked.
