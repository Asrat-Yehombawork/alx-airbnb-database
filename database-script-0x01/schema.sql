-- SQL Schema Definition for Airbnb Clone Database
CREATE DATABASE airbnb_clone;
USE airbnb_clone;

-- Create Roles Table
CREATE TABLE Roles (
    role_id UUID PRIMARY KEY,
    role_name ENUM('guest', 'host', 'admin') NOT NULL
);

-- Create Users Table
CREATE TABLE Users (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role_id UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- Create Locations Table
CREATE TABLE Locations (
    location_id UUID PRIMARY KEY,
    location_name VARCHAR(255) NOT NULL
);

-- Create Properties Table
CREATE TABLE Properties (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location_id UUID NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES Users(user_id),
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

-- Create BookingStatus Table
CREATE TABLE BookingStatus (
    status_id UUID PRIMARY KEY,
    status_name ENUM('pending', 'confirmed', 'canceled') NOT NULL
);

-- Create Bookings Table
CREATE TABLE Bookings (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status_id UUID NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (status_id) REFERENCES BookingStatus(status_id)
);

-- Create Payments Table
CREATE TABLE Payments (
    payment_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

-- Create Reviews Table
CREATE TABLE Reviews (
    review_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create Messages Table
CREATE TABLE Messages (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    FOREIGN KEY (recipient_id) REFERENCES Users(user_id)
);

-- Indexes for Optimization
CREATE INDEX idx_email ON Users (email);
CREATE INDEX idx_host_id ON Properties (host_id);
CREATE INDEX idx_property_id ON Bookings (property_id);
CREATE INDEX idx_user_id ON Bookings (user_id);
CREATE INDEX idx_booking_id ON Payments (booking_id);
