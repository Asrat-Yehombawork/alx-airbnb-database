-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings
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

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews
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

-- 3. FULL OUTER JOIN: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
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
