-- Initial Query to Retrieve All Bookings with User Details, Property Details, and Payment Details
-- This query retrieves all bookings, the users who made them, the properties they booked, and their payments.
-- EXPLAIN ANALYZE is used to analyze the performance of the query.

EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, p.name AS property_name, b.start_date, b.end_date, 
       p.location_id, pay.amount AS payment_amount, pay.payment_date
FROM Bookings b
-- Join the Bookings table with the Users table to get user details for each booking
JOIN Users u ON b.user_id = u.user_id
-- Join the Bookings table with the Properties table to get property details for each booking
JOIN Properties p ON b.property_id = p.property_id
-- Join the Bookings table with the Payments table to get payment details for each booking
JOIN Payments pay ON b.booking_id = pay.booking_id;

-- Refactored Query to Improve Performance
-- In this refactored query, we're limiting the rows scanned by using a WHERE clause and ensuring necessary indexes are in place.
-- The WHERE clause filters the bookings based on the start date, which helps reduce the number of rows involved in the joins.

EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, p.name AS property_name, b.start_date, b.end_date, 
       p.location_id, pay.amount AS payment_amount, pay.payment_date
FROM Bookings b
-- Join the Bookings table with the Users table on user_id to get user details for each booking
JOIN Users u ON b.user_id = u.user_id
-- Join the Bookings table with the Properties table on property_id to get property details for each booking
JOIN Properties p ON b.property_id = p.property_id
-- Join the Bookings table with the Payments table on booking_id to get payment details for each booking
JOIN Payments pay ON b.booking_id = pay.booking_id
-- Example of limiting the rows returned (optional, depending on your use case)
WHERE b.start_date >= '2024-01-01';

-- In this refactored query, performance should improve due to:
-- 1. Filtering early with the WHERE clause.
-- 2. Use of appropriate indexes on columns such as user_id, property_id, and booking_id.
