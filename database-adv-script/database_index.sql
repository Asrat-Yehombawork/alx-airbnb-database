-- Index for fast lookup on the Users table by email
CREATE INDEX idx_users_email ON Users (email);

-- Index for efficient JOINs on Bookings by user_id
CREATE INDEX idx_bookings_user_id ON Bookings (user_id);

-- Index for efficient JOINs on Bookings by property_id
CREATE INDEX idx_bookings_property_id ON Bookings (property_id);

-- Index for filtering properties by location_id
CREATE INDEX idx_properties_location_id ON Properties (location_id);


-- Analyze the performance of a query that retrieves user details along with their booking and property information
EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, b.start_date, b.end_date, p.name 
FROM Users u
-- Join the Users table with the Bookings table on user_id to get booking details for each user
JOIN Bookings b ON u.user_id = b.user_id
-- Join the Bookings table with the Properties table on property_id to get property details for each booking
JOIN Properties p ON b.property_id = p.property_id
-- Filter the results to only include properties in a specific location
WHERE p.location_id = 'location-uuid-123';


-- Analyze the performance of a query that counts the total bookings made by each user
EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, COUNT(b.booking_id) AS total_bookings 
FROM Users u
-- Join the Users table with the Bookings table on user_id to link users to their bookings
JOIN Bookings b ON u.user_id = b.user_id
-- Group the results by user_id to aggregate booking counts for each user
GROUP BY u.user_id;

