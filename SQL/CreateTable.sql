-- MEMBERS
CREATE TABLE members (
member_id SERIAL PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100) UNIQUE,
membership_type VARCHAR(20),
join_date DATE,
region VARCHAR(50)
);

--FACILITIES
CREATE TABLE facilities (
facility_id SERIAL PRIMARY KEY,
name VARCHAR(100),
type VARCHAR(20),
location VARCHAR(50)
);

--CLASSES
CREATE TABLE classes (
class_id SERIAL PRIMARY KEY,
name VARCHAR(100),
instructor VARCHAR(100),
schedule VARCHAR(50)
);

-- BOOKINGS
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    facility_id INT REFERENCES facilities(facility_id),
    class_id INT REFERENCES classes(class_id),
    booking_time TIMESTAMP,
    CONSTRAINT valid_class_booking CHECK (
        (class_id IS NOT NULL AND facility_id IS NOT NULL)
        OR (class_id IS NULL AND facility_id IS NOT NULL)
    )
);

-- USAGE LOGS
CREATE TABLE usage_logs (
    log_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    facility_id INT REFERENCES facilities(facility_id),
    swipe_time TIMESTAMP
);

