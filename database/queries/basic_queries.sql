-- 1. List all flights for a given day
SELECT * FROM Flight
WHERE DATE(departure_time) = '2026-04-01';

-- 2. Find all aircraft of a specific model
SELECT * FROM Aircraft
WHERE model = 'Boeing 737';

-- 3. Show crew assigned to a specific flight
SELECT c.name, c.role
FROM Crew c
JOIN CrewAssignment ca ON c.crew_id = ca.crew_id
WHERE ca.flight_id = 1;

-- 4. List all pending maintenance tasks
SELECT * FROM MaintenanceLog
WHERE status = 'Pending';

-- 5. List all grounded aircraft
SELECT * FROM Aircraft
WHERE status = 'Grounded';

-- 6. Show all flights with their route info
SELECT f.flight_number, r.origin_airport, r.destination_airport
FROM Flight f
JOIN Route r ON f.route_id = r.route_id;

-- 7. Find flights by a specific aircraft
SELECT flight_number, departure_time, arrival_time
FROM Flight
WHERE aircraft_id = 1;

-- 8. Show all crew members of a given role
SELECT * FROM Crew
WHERE role = 'Pilot';

-- 9. Show all maintenance logs for a specific aircraft
SELECT * FROM MaintenanceLog
WHERE aircraft_id = 1;

-- 10. List all airports in Bangladesh
SELECT * FROM Airport
WHERE country = 'Bangladesh';