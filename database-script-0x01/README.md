# Airbnb Clone Database Schema 

This repository contains the SQL script that defines the database schema for an **Airbnb Clone Backend**. The schema is designed to meet the principles of the **Third Normal Form (3NF)**, ensuring efficient data organization, eliminating redundancies, and supporting scalable, secure, and robust backend operations.

## Overview

The database is structured around core entities and their relationships, supporting the essential functionalities of a rental marketplace. These include user management, property management, booking and payment systems, and review functionalities. The schema also incorporates features for optimization, like indexing, and enforces constraints to maintain data integrity.

---

## Features of the Schema

### 1. **Roles**
A dedicated `Roles` table handles user roles such as:
- Guest
- Host
- Admin  

This makes it easy to manage permissions and role-specific functionalities.

### 2. **Users**
The `Users` table manages all platform users. Key attributes include:
- Basic user details like name, email, and phone number
- Role assignment (linked to `Roles` table)
- Password hashing for security
- Timestamps for tracking user activity

### 3. **Properties**
The `Properties` table stores information about the listings created by hosts. Attributes include:
- Property details like name, description, and price
- Host ID (linked to `Users` table)
- Location information (linked to `Locations` table)
- Timestamps for when the property was created or updated

### 4. **Bookings**
The `Bookings` table enables guests to book properties for specific dates. Features include:
- Tracking the property and guest making the booking
- Ensuring booking status (e.g., pending, confirmed, or canceled)
- Calculating the total price based on the stay duration

### 5. **Payments**
The `Payments` table handles financial transactions with attributes like:
- Amount paid
- Payment method (e.g., credit card, PayPal)
- Linked bookings for transparency
- Automatic timestamps for when payments were made

### 6. **Reviews**
The `Reviews` table allows guests to rate and review properties. Attributes include:
- A star-based rating (1 to 5)
- Written comments
- Links to the property and the guest providing the review

### 7. **Messages**
The `Messages` table supports communication between users. Features include:
- Sender and recipient relationships (both linked to the `Users` table)
- Message content
- Timestamps to track when messages are sent

### 8. **Indexes for Optimization**
Key columns, such as `email` in the `Users` table and `property_id` in the `Properties` and `Bookings` tables, are indexed to improve query performance.

---

## How to Use

1. **Setup the Database**  
   Before applying the schema, ensure you have a database ready. For example:
   ```sql
   CREATE DATABASE airbnb_clone;
   USE airbnb_clone;
   ```

2. **Run the Script**  
   Execute the `airbnb_clone_schema.sql` script to create the tables and constraints:
   ```bash
   mysql -u <username> -p airbnb_clone < airbnb_clone_schema.sql
   ```

3. **Verify the Schema**  
   After running the script, verify that all tables and relationships are created correctly:
   ```sql
   SHOW TABLES;
   ```

---

## Why This Schema?

1. **Scalability**  
   The schema uses a modular design, ensuring it can handle an increasing number of users, properties, and bookings as the platform grows.

2. **Data Integrity**  
   Constraints like foreign keys, unique values, and data types ensure the correctness and reliability of the stored data.

3. **Optimization**  
   Indexing and normalized relationships minimize redundancy and speed up query execution.

---

## Feedback and Contributions

If you find any issues or have suggestions for improvement, feel free to open a pull request or issue. Contributions are always welcome! 😊

---

Enjoy exploring the world of **Airbnb Clone Database Development**! 🚀