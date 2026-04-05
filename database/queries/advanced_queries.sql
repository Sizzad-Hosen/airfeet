-- 21. Find aircraft that are NOT under maintenance (EXISTS)
SELECT * FROM Aircraft a
WHERE EXISTS (
    SELECT 1 FROM MaintenanceLog m
    WHERE m.aircraft_id = a.aircraft_id
      AND m.status != 'Ongoing'
);

-- 22. List aircraft that have ANY flight delayed > 60 mins (ANY)
SELECT * FROM Aircraft a
WHERE a.aircraft_id = ANY (
    SELECT f.aircraft_id
    FROM Flight f
    JOIN DelayRecord d ON f.flight_id = d.flight_id
    WHERE d.delay_minutes > 60
);

-- 23. List crew members with overlapping assignments (Window Function)
WITH crew_schedule AS (
    SELECT ca.crew_id, f.departure_time, f.arrival_time,
           ROW_NUMBER() OVER(PARTITION BY ca.crew_id ORDER BY f.departure_time) AS rn
    FROM CrewAssignment ca
    JOIN Flight f ON ca.flight_id = f.flight_id
)
SELECT cs1.crew_id, cs1.departure_time, cs1.arrival_time
FROM crew_schedule cs1
JOIN crew_schedule cs2 ON cs1.crew_id = cs2.crew_id AND cs1.rn = cs2.rn - 1
WHERE cs1.arrival_time > cs2.departure_time;

-- 24. CTE: Top 5 most delayed flights
WITH Delays AS (
    SELECT f.flight_number, d.delay_minutes,
           RANK() OVER(ORDER BY d.delay_minutes DESC) AS delay_rank
    FROM Flight f
    JOIN DelayRecord d ON f.flight_id = d.flight_id
)
SELECT flight_number, delay_minutes FROM Delays
WHERE delay_rank <= 5;

-- 25. View: Flight with crew details
CREATE VIEW FlightCrewView AS
SELECT f.flight_number, f.departure_time, f.arrival_time,
       c.name AS crew_name, c.role AS crew_role
FROM Flight f
JOIN CrewAssignment ca ON f.flight_id = ca.flight_id
JOIN Crew c ON ca.crew_id = c.crew_id;

-- 26. View: Aircraft utilization (total flight hours)
CREATE VIEW AircraftUtilization AS
SELECT a.aircraft_id, a.model, SUM(r.duration_hours) AS total_hours
FROM Aircraft a
JOIN Flight f ON a.aircraft_id = f.aircraft_id
JOIN Route r ON f.route_id = r.route_id
GROUP BY a.aircraft_id, a.model;

-- 27. View: Pending maintenance tasks
CREATE VIEW PendingMaintenance AS
SELECT m.maintenance_id, a.model, e.name AS engineer_name, m.status
FROM MaintenanceLog m
JOIN Aircraft a ON m.aircraft_id = a.aircraft_id
JOIN Engineer e ON m.engineer_id = e.engineer_id
WHERE m.status = 'Pending';

-- 28. Trigger: Prevent scheduling a flight if aircraft under maintenance
CREATE TRIGGER prevent_flight_insert
BEFORE INSERT ON Flight
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM MaintenanceLog
        WHERE aircraft_id = NEW.aircraft_id
          AND status = 'Ongoing'
          AND ((NEW.departure_time BETWEEN start_time AND end_time)
               OR (NEW.arrival_time BETWEEN start_time AND end_time))
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Aircraft under maintenance';
    END IF;
END;

-- 29. Trigger: Log crew assignment changes
CREATE TABLE CrewAssignmentLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    crew_id INT,
    flight_id INT,
    action VARCHAR(20),
    action_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER log_crew_assignment
AFTER INSERT ON CrewAssignment
FOR EACH ROW
BEGIN
    INSERT INTO CrewAssignmentLog (crew_id, flight_id, action)
    VALUES (NEW.crew_id, NEW.flight_id, 'Assigned');
END;

-- 30. Detect flights where actual arrival − planned arrival > 60 mins
SELECT f.flight_number, d.delay_minutes
FROM Flight f
JOIN DelayRecord d ON f.flight_id = d.flight_id
WHERE d.delay_minutes > 60;