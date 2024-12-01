### **Normalization to Achieve Third Normal Form (3NF)**

To ensure the database is normalized to 3NF, we applied the following steps to eliminate redundancies and ensure dependency relationships are properly structured.

---

### **Step 1: Analyze for 1NF (First Normal Form)**
**Objective:** Ensure that all tables have atomic values, unique rows, and each column contains a single value.

- **User Table:** Already satisfies 1NF as all attributes are atomic (e.g., `first_name`, `last_name`) and uniquely identified by `user_id`.
- **Property Table:** Each property detail (e.g., `name`, `location`, `price_per_night`) is atomic, and the table uses `property_id` as a unique identifier.
- **Booking Table:** Attributes (e.g., `start_date`, `end_date`, `status`) are atomic and uniquely identified by `booking_id`.
- **Payment Table:** Each payment is uniquely identified by `payment_id` and associated with a booking using `booking_id`.
- **Review Table:** Attributes like `rating` and `comment` are atomic. Each review is tied to a unique `review_id`.
- **Message Table:** Attributes like `message_body` are atomic, and the table uses `message_id` as a unique identifier.

**Result:** All tables satisfy 1NF.

---

### **Step 2: Analyze for 2NF (Second Normal Form)**
**Objective:** Ensure no partial dependencies exist; all non-key attributes should depend on the entire primary key.

- **User Table:** No composite key exists, so no partial dependencies. Attributes such as `email` and `phone_number` depend entirely on `user_id`.
- **Property Table:** No partial dependencies. Each attribute (e.g., `name`, `location`, `price_per_night`) depends entirely on `property_id`.
- **Booking Table:** No partial dependencies. Attributes like `start_date` and `end_date` depend entirely on `booking_id`.
- **Payment Table:** Attributes like `amount` and `payment_method` depend entirely on `payment_id`.
- **Review Table:** Attributes depend entirely on `review_id`.
- **Message Table:** Attributes depend entirely on `message_id`.

**Result:** All tables satisfy 2NF.

---

### **Step 3: Analyze for 3NF (Third Normal Form)**
**Objective:** Remove transitive dependencies; ensure all attributes depend only on the primary key.

#### Identified Potential Issues:
1. **User Table:**
   - `role` could be normalized into a separate table to reduce redundancy, especially if the system adds new roles in the future (e.g., super-admin, moderator).
   - Suggested Solution: Move `role` to a `Roles` table.
   
2. **Property Table:**
   - `location` might be reused across multiple properties, leading to redundancy.
   - Suggested Solution: Normalize `location` into a separate `Locations` table.

3. **Booking Table:**
   - `status` as an ENUM is acceptable but might grow over time. Normalizing it can provide flexibility for changes.
   - Suggested Solution: Create a `BookingStatus` table.

4. **Payment Table:**
   - `payment_method` as an ENUM is acceptable but could also benefit from normalization for extensibility.
   - Suggested Solution: Normalize `payment_method` into a `PaymentMethods` table.

---

### **Revised Schema with Normalization**

#### **User Table**
| Attribute        | Type        | Description                     |
|------------------|-------------|---------------------------------|
| `user_id`        | UUID        | Primary key, uniquely identifies users. |
| `first_name`     | VARCHAR     | First name of the user.         |
| `last_name`      | VARCHAR     | Last name of the user.          |
| `email`          | VARCHAR     | Unique, user email address.     |
| `password_hash`  | VARCHAR     | Hashed password.                |
| `phone_number`   | VARCHAR     | Optional phone number.          |
| `role_id`        | UUID        | Foreign key to `Roles(role_id)`.|
| `created_at`     | TIMESTAMP   | Record creation timestamp.      |

---

#### **Roles Table**
| Attribute        | Type        | Description                     |
|------------------|-------------|---------------------------------|
| `role_id`        | UUID        | Primary key.                    |
| `role_name`      | ENUM        | Role name (guest, host, admin). |

---

#### **Property Table**
| Attribute        | Type        | Description                     |
|------------------|-------------|---------------------------------|
| `property_id`    | UUID        | Primary key.                    |
| `host_id`        | UUID        | Foreign key to `User(user_id)`. |
| `name`           | VARCHAR     | Name of the property.           |
| `description`    | TEXT        | Description of the property.    |
| `location_id`    | UUID        | Foreign key to `Locations(location_id)`. |
| `price_per_night`| DECIMAL     | Nightly rate.                   |
| `created_at`     | TIMESTAMP   | Timestamp when record was created. |
| `updated_at`     | TIMESTAMP   | Auto-updated on modification.   |

---

#### **Locations Table**
| Attribute        | Type        | Description                     |
|------------------|-------------|---------------------------------|
| `location_id`    | UUID        | Primary key.                    |
| `location_name`  | VARCHAR     | Location name.                  |

---

#### **Booking Table**
| Attribute        | Type        | Description                     |
|------------------|-------------|---------------------------------|
| `booking_id`     | UUID        | Primary key.                    |
| `property_id`    | UUID        | Foreign key to `Property(property_id)`. |
| `user_id`        | UUID        | Foreign key to `User(user_id)`. |
| `start_date`     | DATE        | Booking start date.             |
| `end_date`       | DATE        | Booking end date.               |
| `status_id`      | UUID        | Foreign key to `BookingStatus(status_id)`. |
| `total_price`    | DECIMAL     | Total booking cost.             |
| `created_at`     | TIMESTAMP   | Record creation timestamp.      |

---

#### **BookingStatus Table**
| Attribute        | Type        | Description                     |
|------------------|-------------|---------------------------------|
| `status_id`      | UUID        | Primary key.                    |
| `status_name`    | ENUM        | Booking status (pending, confirmed, canceled). |

---

### **Explanation of Normalization**
1. **Roles Table**: Removes redundancy for user roles.
2. **Locations Table**: Centralizes and standardizes location data, reducing redundancy across properties.
3. **BookingStatus Table**: Provides flexibility in managing booking statuses.
4. **PaymentMethods Table** (not explicitly shown but follows the same logic): Can standardize and extend payment options.

**Result:** The schema is now in 3NF, ensuring no data redundancy and enabling better scalability and maintainability.