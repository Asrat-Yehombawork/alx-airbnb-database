-- Query 1: Total number of bookings made by each user
-- Using the COUNT function and GROUP BY clause to aggregate data
SELECT 
    b.user_id, -- Selects the user_id from the Booking table
    u.first_name, -- Retrieves the user's first name from the User table
    u.last_name, -- Retrieves the user's last name from the User table
    COUNT(b.booking_id) AS total_bookings -- Counts the number of bookings per user
FROM 
    Booking b -- The Booking table contains all booking data
JOIN 
    User u ON b.user_id = u.user_id -- Joins the User table to link bookings to specific users
GROUP BY 
    b.user_id, -- Groups the results by user_id to calculate the count for each user
    u.first_name, -- Ensures first_name is part of the grouping to avoid ambiguity
    u.last_name -- Ensures last_name is part of the grouping to avoid ambiguity
ORDER BY 
    total_bookings DESC; -- Orders the result by the total number of bookings in descending order

-- Query 2: Rank properties based on the total number of bookings
-- Using the ROW_NUMBER and RANK window functions
SELECT 
    p.property_id, -- Selects the unique identifier for each property
    p.name AS property_name, -- Retrieves the name of the property
    COUNT(b.booking_id) AS total_bookings, -- Counts the total number of bookings for each property
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_number_rank, 
    -- ROW_NUMBER assigns a unique rank to each property, with no ties
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank 
    -- RANK assigns the same rank to properties with the same booking count
FROM 
    Property p -- The Property table contains data about all properties
LEFT JOIN 
    Booking b ON p.property_id = b.property_id 
    -- LEFT JOIN ensures properties with no bookings are included in the results
GROUP BY 
    p.property_id, -- Groups by property_id to aggregate booking counts
    p.name -- Includes the property name in the grouping to avoid ambiguity
ORDER BY 
    total_bookings DESC; -- Orders the result by total bookings in descending order
