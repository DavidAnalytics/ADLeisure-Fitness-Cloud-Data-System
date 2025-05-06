----Member with Most Bookings in the Last 30days-----

--#This filters bookings to only the last 30days (recent_bookings)
--#Then counts how many times each member booked (member_activity)
--#Finally, joins with the members table for details

WITH recent_bookings AS (
	SELECT * 
	FROM bookings
	WHERE booking_time >= CURRENT_DATE - INTERVAL '30 days'
),
member_activity AS (
	SELECT
		member_id,
		COUNT(*) AS total_bookings
	FROM recent_bookings
	GROUP BY member_id
)
SELECT 
	m.member_id,
	m.first_name,
	m.last_name,
	ma.total_bookings                                                                 
FROM member_activity ma
JOIN members m 
ON m.member_id = ma.member_id
ORDER BY ma.total_bookings ASC
Limit 10;



-----Class Popularity Over Time With Rolling 3-week Average Attendance----
--#Count number of bookings per class each week
WITH weekly_attendance AS (
    SELECT 
        class_id,
        DATE_TRUNC('week', booking_time) AS week_start, -- start of each week
        COUNT(*) AS attendance
    FROM bookings
    WHERE class_id IS NOT NULL
    GROUP BY class_id, DATE_TRUNC('week', booking_time)
)
-- #Add rollinmg 3 -week average using a window function
SELECT 
    c.name AS class_name,
    wa.week_start,
    wa.attendance,
    
    --#Calculates average attendance across this and previous 2 weeks
    ROUND(AVG(wa.attendance) OVER (             -- We're computing the average of attendance values.
        PARTITION BY wa.class_id               -- Do the rolling calculation per class, separately.
        ORDER BY wa.week_start                 -- Make sure rows are ordered by week within each class.
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW  -- Only look at this week and the 2 weeks before it — so, a 3-week rolling window.
    ), 2) AS rolling_avg_3_weeks

FROM weekly_attendance wa
JOIN classes c 
ON wa.class_id = c.class_id
ORDER BY c.name, wa.week_start ASC;
