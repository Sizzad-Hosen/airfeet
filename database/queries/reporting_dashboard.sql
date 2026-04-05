-- =========================================
-- 1. MONTHLY FLIGHT DELAYS
-- =========================================
SELECT 
    MONTH(f.departure_time) AS month,
    SUM(d.delay_minutes) AS total_delay_minutes
FROM Flight f
JOIN DelayRecord d ON f.flight_id = d.flight_id
GROUP BY MONTH(f.departure_time)
ORDER BY month;


-- =========================================
-- 2. MOST ACTIVE ROUTES
-- =========================================
SELECT 
    CONCAT(a1.airport_name, ' → ', a2.airport_name) AS route,
    COUNT(*) AS total_flights
FROM Flight f
JOIN Route r ON f.route_id = r.route_id
JOIN Airport a1 ON r.origin_airport = a1.airport_id
JOIN Airport a2 ON r.destination_airport = a2.airport_id
GROUP BY route
ORDER BY total_flights DESC;


-- =========================================
-- 3. MOST USED AIRCRAFT
-- =========================================
SELECT 
    a.model,
    COUNT(f.flight_id) AS total_flights,
    SUM(r.duration_hours) AS total_flight_hours
FROM Aircraft a
JOIN Flight f ON a.aircraft_id = f.aircraft_id
JOIN Route r ON f.route_id = r.route_id
GROUP BY a.model
ORDER BY total_flight_hours DESC;


-- =========================================
-- 4. CREW DUTY ROSTER (HEATMAP DATA)
-- =========================================
SELECT 
    c.name AS crew_name,
    DATE(f.departure_time) AS duty_date,
    COUNT(f.flight_id) AS flights_per_day
FROM Crew c
JOIN CrewAssignment ca ON c.crew_id = ca.crew_id
JOIN Flight f ON ca.flight_id = f.flight_id
GROUP BY c.name, DATE(f.departure_time)
ORDER BY c.name, duty_date;


-- =========================================
-- 5. MAINTENANCE FREQUENCY PER AIRCRAFT MODEL
-- =========================================
SELECT 
    a.model,
    COUNT(m.maintenance_id) AS maintenance_count
FROM Aircraft a
JOIN MaintenanceLog m ON a.aircraft_id = m.aircraft_id
GROUP BY a.model
ORDER BY maintenance_count DESC;