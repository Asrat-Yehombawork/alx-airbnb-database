-- Index for fast lookup on the Users table by email
CREATE INDEX idx_users_email ON Users (email);

-- Index for efficient JOINs on Bookings by user_id
CREATE INDEX idx_bookings_user_id ON Bookings (user_id);

-- Index for efficient JOINs on Bookings by property_id
CREATE INDEX idx_bookings_property_id ON Bookings (property_id);

-- Index for filtering properties by location_id
CREATE INDEX idx_properties_location_id ON Properties (location_id);