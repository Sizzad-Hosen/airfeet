-- Flight time index
CREATE INDEX idx_flight_departure ON Flight(departure_time);

-- Route index
CREATE INDEX idx_flight_route ON Flight(route_id);

-- Aircraft usage index
CREATE INDEX idx_aircraft_usage ON Flight(aircraft_id);