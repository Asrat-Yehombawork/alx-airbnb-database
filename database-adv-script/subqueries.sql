-- Non-Correlated Subquery
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

-- Correlated Subquery
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
