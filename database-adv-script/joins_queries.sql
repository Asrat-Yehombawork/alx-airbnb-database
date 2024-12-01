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

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties with no reviews
SELECT 
    p.property_id,
    p.name AS property_name,
    r.review_id,
    r.rating,
    r.comment
FROM 
    Property p
LEFT JOIN 
    Review r
ON 
    p.property_id = r.property_id
ORDER BY 
    p.name;  -- Ordering the results by property name


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
