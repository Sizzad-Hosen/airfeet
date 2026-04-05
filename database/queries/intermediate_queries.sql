-- 1. Count number of flights per aircraft
SELECT aircraft_id, COUNT(*) AS num_flights
FROM Flight
GROUP BY aircraft_id;

-- 2. Average delay per route
SELECT route_id, AVG(delay_minutes) AS avg_delay
FROM DelayRecord
JOIN Flight f ON DelayRecord.flight_id = f.flight_id
GROUP BY route_id;

-- 3. Aircraft with more than 1000 total flight hours
SELECT * FROM Aircraft
WHERE total_flight_hours > 1000;

-- 4. Flights delayed more than system average
SELECT f.flight_number, d.delay_minutes
FROM Flight f
JOIN DelayRecord d ON f.flight_id = d.flight_id
WHERE d.delay_minutes > (SELECT AVG(delay_minutes) FROM DelayRecord);

-- 5. Number of crew members per flight
SELECT flight_id, COUNT(*) AS crew_count
FROM CrewAssignment
GROUP BY flight_id;

-- 6. Count of maintenance tasks per engineer
SELECT engineer_id, COUNT(*) AS tasks
FROM MaintenanceLog
GROUP BY engineer_id;

-- 7. Flights grouped by status
SELECT status, COUNT(*) AS total
FROM Flight
GROUP BY status;

-- 8. Flights per route having more than 1 delay
SELECT f.route_id, COUNT(d.delay_id) AS delay_count
FROM Flight f
JOIN DelayRecord d ON f.flight_id = d.flight_id
GROUP BY f.route_id
HAVING COUNT(d.delay_id) > 1;

-- 9. Crew members who have not flown today
SELECT * FROM Crew
WHERE crew_id NOT IN (
    SELECT crew_id FROM CrewAssignment
    JOIN Flight ON CrewAssignment.flight_id = Flight.flight_id
    WHERE DATE(departure_time) = '2026-04-01'
);

-- 10. List flights with duration more than 5 hours
SELECT f.flight_number, r.duration_hours
FROM Flight f
JOIN Route r ON f.route_id = r.route_id
WHERE r.duration_hours > 5;