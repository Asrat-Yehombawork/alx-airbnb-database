-- Insert sample roles
INSERT INTO Roles (role_id, role_name) VALUES
    (1, 'guest'),
    (2, 'host'),
    (3, 'admin');

-- Insert sample users
INSERT INTO Users (user_id, first_name, last_name, email, password_hash, phone_number, role_id, created_at) VALUES
    (UUID(), 'John', 'Doe', 'john.doe@example.com', 'hashed_password_1', '1234567890', 1, NOW()),
    (UUID(), 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password_2', '9876543210', 2, NOW()),
    (UUID(), 'Alice', 'Brown', 'alice.brown@example.com', 'hashed_password_3', NULL, 3, NOW());

-- Insert sample locations
INSERT INTO Locations (location_id, city, country, created_at) VALUES
    (UUID(), 'New York', 'USA', NOW()),
    (UUID(), 'London', 'UK', NOW()),
    (UUID(), 'Tokyo', 'Japan', NOW());

-- Insert sample properties
INSERT INTO Properties (property_id, host_id, name, description, location_id, price_per_night, created_at, updated_at) VALUES
    (UUID(), (SELECT user_id FROM Users WHERE email = 'jane.smith@example.com'), 'Cozy Apartment in NY', 'A comfortable 2-bedroom apartment in the heart of NYC.', (SELECT location_id FROM Locations WHERE city = 'New York'), 150.00, NOW(), NOW()),
    (UUID(), (SELECT user_id FROM Users WHERE email = 'jane.smith@example.com'), 'Modern Flat in London', 'A stylish flat close to central London attractions.', (SELECT location_id FROM Locations WHERE city = 'London'), 200.00, NOW(), NOW()),
    (UUID(), (SELECT user_id FROM Users WHERE email = 'jane.smith@example.com'), 'Traditional House in Tokyo', 'Experience Tokyo in a beautiful traditional house.', (SELECT location_id FROM Locations WHERE city = 'Tokyo'), 120.00, NOW(), NOW());

-- Insert sample bookings
INSERT INTO Bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
    (UUID(), (SELECT property_id FROM Properties WHERE name = 'Cozy Apartment in NY'), (SELECT user_id FROM Users WHERE email = 'john.doe@example.com'), '2024-11-01', '2024-11-05', 600.00, 'confirmed', NOW()),
    (UUID(), (SELECT property_id FROM Properties WHERE name = 'Modern Flat in London'), (SELECT user_id FROM Users WHERE email = 'john.doe@example.com'), '2024-11-10', '2024-11-15', 1000.00, 'pending', NOW()),
    (UUID(), (SELECT property_id FROM Properties WHERE name = 'Traditional House in Tokyo'), (SELECT user_id FROM Users WHERE email = 'john.doe@example.com'), '2024-12-01', '2024-12-07', 840.00, 'canceled', NOW());

-- Insert sample payments
INSERT INTO Payments (payment_id, booking_id, amount, payment_date, payment_method) VALUES
    (UUID(), (SELECT booking_id FROM Bookings WHERE total_price = 600.00), 600.00, NOW(), 'credit_card'),
    (UUID(), (SELECT booking_id FROM Bookings WHERE total_price = 1000.00), 1000.00, NOW(), 'paypal');

-- Insert sample reviews
INSERT INTO Reviews (review_id, property_id, user_id, rating, comment, created_at) VALUES
    (UUID(), (SELECT property_id FROM Properties WHERE name = 'Cozy Apartment in NY'), (SELECT user_id FROM Users WHERE email = 'john.doe@example.com'), 5, 'Amazing place! Would definitely stay again.', NOW()),
    (UUID(), (SELECT property_id FROM Properties WHERE name = 'Modern Flat in London'), (SELECT user_id FROM Users WHERE email = 'john.doe@example.com'), 4, 'Great location, but slightly noisy at night.', NOW());

-- Insert sample messages
INSERT INTO Messages (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
    (UUID(), (SELECT user_id FROM Users WHERE email = 'john.doe@example.com'), (SELECT user_id FROM Users WHERE email = 'jane.smith@example.com'), 'Is the apartment available for next weekend?', NOW()),
    (UUID(), (SELECT user_id FROM Users WHERE email = 'jane.smith@example.com'), (SELECT user_id FROM Users WHERE email = 'john.doe@example.com'), 'Yes, it is available!', NOW());
