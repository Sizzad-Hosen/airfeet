-- 1. Aircraft with more than 5 flights without maintenance
SELECT aircraft_id, COUNT(*) AS flight_count
FROM Flight f
WHERE aircraft_id NOT IN (
    SELECT aircraft_id FROM MaintenanceLog
)
GROUP BY aircraft_id
HAVING COUNT(*) > 5;

-- 2. Crew with overlapping schedules
-- (Already done in query 23)

-- 3. Routes with highest average delays
SELECT r.route_id, r.origin_airport, r.destination_airport,
       AVG(d.delay_minutes) AS avg_delay
FROM Flight f
JOIN Route r ON f.route_id = r.route_id
JOIN DelayRecord d ON f.flight_id = d.flight_id
GROUP BY r.route_id
ORDER BY avg_delay DESC
LIMIT 5;

-- 4. Monthly aircraft utilization rate
SELECT aircraft_id, MONTH(f.departure_time) AS month,
       SUM(r.duration_hours) AS total_hours
FROM Flight f
JOIN Route r ON f.route_id = r.route_id
GROUP BY aircraft_id, MONTH(f.departure_time);

-- 5. Engineers with most maintenance tasks
SELECT engineer_id, COUNT(*) AS task_count
FROM MaintenanceLog
GROUP BY engineer_id
ORDER BY task_count DESC
LIMIT 5;

-- 6. Detect crew rest period violations (< 8 hours)
SELECT ca1.crew_id, ca1.flight_id AS flight1, ca2.flight_id AS flight2,
       TIMESTAMPDIFF(HOUR, f1.arrival_time, f2.departure_time) AS rest_hours
FROM CrewAssignment ca1
JOIN CrewAssignment ca2 ON ca1.crew_id = ca2.crew_id AND ca1.flight_id != ca2.flight_id
JOIN Flight f1 ON ca1.flight_id = f1.flight_id
JOIN Flight f2 ON ca2.flight_id = f2.flight_id
WHERE f2.departure_time > f1.arrival_time
  AND TIMESTAMPDIFF(HOUR, f1.arrival_time, f2.departure_time) < 8;

-- 7. Total flight hours per aircraft
SELECT a.aircraft_id, a.model, SUM(r.duration_hours) AS total_hours
FROM Flight f
JOIN Aircraft a ON f.aircraft_id = a.aircraft_id
JOIN Route r ON f.route_id = r.route_id
GROUP BY a.aircraft_id;

-- 8. Top 5 most frequent routes
SELECT route_id, COUNT(*) AS flight_count
FROM Flight
GROUP BY route_id
ORDER BY flight_count DESC
LIMIT 5;

-- 9. Flights where actual arrival − planned arrival > threshold (e.g., 60 mins)
SELECT f.flight_number, d.delay_minutes
FROM Flight f
JOIN DelayRecord d ON f.flight_id = d.flight_id
WHERE d.delay_minutes > 60;

-- 10. Mean Time Between Maintenance (MTBM) per aircraft
SELECT aircraft_id, AVG(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS mtbm_hours
FROM MaintenanceLog
GROUP BY aircraft_id;