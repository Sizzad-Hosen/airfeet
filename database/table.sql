-- CREATE DATABASE


CREATE TABLE Aircraft (
  aircraft_id SERIAL PRIMARY KEY,
  model VARCHAR(50) NOT NULL,
  manufacturer VARCHAR(50),
  capacity INT CHECK (capacity > 0),
  status VARCHAR(20) CHECK (status IN ('Active','Grounded')),
  total_flight_hours FLOAT DEFAULT 0,
  current_airport_id INT REFERENCES Airport(airport_id)
);

CREATE TABLE Airport (
  airport_id SERIAL PRIMARY KEY,
  airport_name VARCHAR(100) NOT NULL,
  city VARCHAR(50),
  country VARCHAR(50),
  iata_code CHAR(3) UNIQUE
);

CREATE TABLE Route (
  route_id SERIAL PRIMARY KEY,
  origin_airport INT,
  destination_airport INT,
  distance_km FLOAT CHECK (distance_km > 0),
  duration_hours FLOAT CHECK (duration_hours > 0),

  FOREIGN KEY (origin_airport) REFERENCES Airport(airport_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  FOREIGN KEY (destination_airport) REFERENCES Airport(airport_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  CHECK (origin_airport <> destination_airport)
);

CREATE TABLE Flight (
  flight_id SERIAL PRIMARY KEY,
  flight_number VARCHAR(20) UNIQUE NOT NULL,
  departure_time TIMESTAMP NOT NULL,
  arrival_time TIMESTAMP NOT NULL,
  status VARCHAR(20) CHECK (status IN ('On-Time','Delayed','Cancelled')),
  aircraft_id INT,
  route_id INT,

  FOREIGN KEY (aircraft_id) REFERENCES Aircraft(aircraft_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  FOREIGN KEY (route_id) REFERENCES Route(route_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  CHECK (arrival_time > departure_time)
);


CREATE TABLE Crew (
  crew_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  role VARCHAR(20) CHECK (role IN ('Pilot','Co-Pilot','CabinCrew')),
  license_number VARCHAR(50) UNIQUE,
  total_duty_hours FLOAT DEFAULT 0,
  last_rest_time TIMESTAMP
);


CREATE TABLE CrewAssignment (
  assignment_id SERIAL PRIMARY KEY,
  crew_id INT,
  flight_id INT,
  assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  role_on_flight VARCHAR(20),

  FOREIGN KEY (crew_id) REFERENCES Crew(crew_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  UNIQUE (crew_id, flight_id) -- prevent duplicate assignment
);


CREATE TABLE Engineer (
  engineer_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  specialization VARCHAR(50),
  certified_since DATE
);



CREATE TABLE MaintenanceLog (
  maintenance_id SERIAL PRIMARY KEY,
  aircraft_id INT,
  engineer_id INT,
  start_time TIMESTAMP,
  end_time TIMESTAMP,
  type VARCHAR(20) CHECK (type IN ('Routine','Emergency','Inspection')),
  status VARCHAR(20) CHECK (status IN ('Pending','Ongoing','Completed')),

  FOREIGN KEY (aircraft_id) REFERENCES Aircraft(aircraft_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  FOREIGN KEY (engineer_id) REFERENCES Engineer(engineer_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE,

  CHECK (end_time > start_time)
);


CREATE TABLE DelayRecord (
  delay_id SERIAL PRIMARY KEY,
  flight_id INT,
  delay_minutes INT CHECK (delay_minutes >= 0),
  reason VARCHAR(100),
  reported_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

