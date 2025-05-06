-- WEEKLY ATTENDANCE BY CLASS
SELECT 
c.name AS class_name,
TO_CHAR(DATE_TRUNC('week', b.booking_time), 'DD-Mon-YYYY') AS week_start,
COUNT(*) AS total_attendance
FROM bookings b
JOIN classes c 
ON b.class_id = c.class_id
GROUP BY c.name, DATE_TRUNC('week', b.booking_time)
ORDER BY week_start, total_attendance DESC;


-- PEAK vs LOW USAGE HOURS (across all facilities)
SELECT 
TO_CHAR(booking_time, 'HH24:00') AS hour_of_day, -- This uses the TO_CHAR() function to format the booking_time into a string like "11:00", "18:00", "21:00" (24-hour format). The HH24 specifies the 24-hour format.
COUNT(*) AS total_bookings
FROM bookings
GROUP BY hour_of_day
ORDER BY total_bookings DESC;

--TO IDENTIFY UNDERUSED FACILITY
SELECT 
f.facility_id,
f.name AS facility_name,
f.type AS facility_type,
f.location AS facility_location,
TO_CHAR(b.booking_time, 'HH24:00') AS hour_of_day,  -- Hour in 24-hour format
COUNT(*) AS total_bookings
FROM bookings b
JOIN facilities f 
ON b.facility_id = f.facility_id
GROUP BY f.facility_id, f.name, f.type, f.location, TO_CHAR(b.booking_time, 'HH24:00')
HAVING 
    COUNT(*) < 5  -- Filter for facilities with fewer than 5 bookings in a given hour
ORDER BY total_bookings ASC;  -- Order by the least booked facilities (underused ones)


--MEMBER ACTIVITY TRENDS OVER TIME
SELECT
TO_CHAR(DATE_TRUNC('month',booking_time), 'DD-Mon-YYYY') AS month,
COUNT(DISTINCT member_id) AS active_members
FROM bookings
GROUP BY month
ORDER BY month ASC;

--MEMBERS LIKELY TO CHURN (No Bookings in Last 30 days)
SELECT
m.member_id,
m.first_name,
m.last_name,
MAX(booking_time)AS last_booking
FROM members m
LEFT JOIN bookings b
ON m.member_id = b.member_id
GROUP BY m.member_id, m.first_name, m.last_name
HAVING MAX(b.booking_time)< CURRENT_DATE - INTERVAL '30 days'
OR MAX(b.booking_time) IS NULL;

--INSTRUCTOR POPULARITY BY AVERAGE ATTENDANCE PER CLASS
SELECT 
c.instructor,
c.name AS class_name,
COUNT(b.booking_id) AS total_bookings
FROM classes c
LEFT JOIN bookings b ON c.class_id = b.class_id
GROUP BY c.instructor, c.name
ORDER BY total_bookings DESC;



