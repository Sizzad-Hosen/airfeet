
-- Insert sample data into the Aircraft table
INSERT INTO Aircraft (model, manufacturer, capacity, status, total_flight_hours) VALUES
('Boeing 737','Boeing',180,'Active',1200),
('Airbus A320','Airbus',170,'Active',980),
('Boeing 777','Boeing',300,'Active',2000),
('Airbus A330','Airbus',250,'Active',1500),
('Boeing 787','Boeing',280,'Active',1700),
('ATR 72','ATR',70,'Active',600),
('Dash 8','Bombardier',80,'Active',700),
('Embraer E190','Embraer',100,'Active',850),
('Airbus A321','Airbus',200,'Active',1100),
('Boeing 747','Boeing',400,'Grounded',2500),
('Airbus A350','Airbus',320,'Active',1900),
('Boeing 767','Boeing',220,'Active',1400);


-- Insert sample data into the Airport table
INSERT INTO Airport (airport_name, city, country, iata_code) VALUES
('Hazrat Shahjalal Intl','Dhaka','Bangladesh','DAC'),
('Shah Amanat Intl','Chittagong','Bangladesh','CGP'),
('Osmani Intl','Sylhet','Bangladesh','ZYL'),
('Dubai Intl','Dubai','UAE','DXB'),
('Heathrow','London','UK','LHR'),
('Suvarnabhumi','Bangkok','Thailand','BKK'),
('KL Intl','Kuala Lumpur','Malaysia','KUL'),
('Indira Gandhi Intl','Delhi','India','DEL');

-- Insert sample data into the Route table
INSERT INTO Route (origin_airport, destination_airport, distance_km, duration_hours) VALUES
(1,2,250,1),
(1,3,300,1.2),
(1,4,3500,5),
(1,5,8000,10),
(2,4,3200,4.5),
(3,5,7800,9.5),
(1,6,2200,3.5),
(1,7,3000,4),
(1,8,1500,2.5),
(2,3,200,0.8);

-- Insert sample data into the Flight table
INSERT INTO Crew (name, role, license_number, total_duty_hours, last_rest_time) VALUES
('Rahim','Pilot','LIC001',500,'2026-03-31 08:00'),
('Karim','Co-Pilot','LIC002',450,'2026-03-31 08:00'),
('Sakib','CabinCrew','LIC003',300,'2026-03-31 08:00'),
('Tamim','Pilot','LIC004',520,'2026-03-31 09:00'),
('Shanto','Co-Pilot','LIC005',430,'2026-03-31 09:00'),
('Mithun','CabinCrew','LIC006',310,'2026-03-31 09:00'),
('Rafi','CabinCrew','LIC007',290,'2026-03-31 10:00'),
('Naim','Pilot','LIC008',600,'2026-03-31 10:00'),
('Jony','Co-Pilot','LIC009',410,'2026-03-31 10:00'),
('Hasan','CabinCrew','LIC010',280,'2026-03-31 10:00'),
('Rasel','CabinCrew','LIC011',260,'2026-03-31 11:00'),
('Imran','Pilot','LIC012',550,'2026-03-31 11:00'),
('Sabbir','Co-Pilot','LIC013',400,'2026-03-31 11:00'),
('Rakib','CabinCrew','LIC014',270,'2026-03-31 12:00'),
('Fahim','CabinCrew','LIC015',260,'2026-03-31 12:00'),
('Nayeem','Pilot','LIC016',620,'2026-03-31 12:00'),
('Shakil','Co-Pilot','LIC017',390,'2026-03-31 12:00'),
('Arif','CabinCrew','LIC018',240,'2026-03-31 13:00'),
('Bappy','CabinCrew','LIC019',230,'2026-03-31 13:00'),
('Sumon','CabinCrew','LIC020',220,'2026-03-31 13:00'),
('Rony','Pilot','LIC021',530,'2026-03-31 14:00'),
('Tarek','Co-Pilot','LIC022',420,'2026-03-31 14:00');

-- Insert sample data into the Flight table
INSERT INTO Flight (flight_number, aircraft_id, route_id, departure_time, arrival_time, status) VALUES
('BG101',1,1,'2026-04-01 08:00','2026-04-01 09:00','On-Time'),
('BG102',2,2,'2026-04-01 10:00','2026-04-01 11:30','On-Time'),
('BG103',3,3,'2026-04-01 12:00','2026-04-01 18:00','Delayed'),
('BG104',4,4,'2026-04-02 09:00','2026-04-02 15:00','On-Time'),
('BG105',5,5,'2026-04-02 16:00','2026-04-02 20:00','On-Time'),
('BG106',6,6,'2026-04-03 07:00','2026-04-03 10:00','Delayed'),
('BG107',7,7,'2026-04-03 11:00','2026-04-03 15:00','On-Time'),
('BG108',8,8,'2026-04-03 16:00','2026-04-03 20:00','On-Time'),
('BG109',9,1,'2026-04-04 08:00','2026-04-04 09:00','On-Time'),
('BG110',10,2,'2026-04-04 10:00','2026-04-04 12:00','Cancelled'),
('BG111',11,3,'2026-04-05 08:00','2026-04-05 13:00','On-Time'),
('BG112',12,4,'2026-04-05 14:00','2026-04-05 20:00','Delayed'),
('BG113',1,5,'2026-04-06 09:00','2026-04-06 13:00','On-Time'),
('BG114',2,6,'2026-04-06 14:00','2026-04-06 18:00','On-Time'),
('BG115',3,7,'2026-04-07 07:00','2026-04-07 11:00','On-Time'),
('BG116',4,8,'2026-04-07 12:00','2026-04-07 16:00','On-Time'),
('BG117',5,9,'2026-04-08 08:00','2026-04-08 10:30','Delayed'),
('BG118',6,10,'2026-04-08 11:00','2026-04-08 12:00','On-Time'),
('BG119',7,1,'2026-04-09 09:00','2026-04-09 10:00','On-Time'),
('BG120',8,2,'2026-04-09 11:00','2026-04-09 12:30','On-Time');

-- Insert sample data into the CrewAssignment table

INSERT INTO CrewAssignment (crew_id, flight_id, role_on_flight) VALUES
(1,1,'Pilot'),(2,1,'Co-Pilot'),(3,1,'CabinCrew'),
(4,2,'Pilot'),(5,2,'Co-Pilot'),(6,2,'CabinCrew'),
(8,3,'Pilot'),(9,3,'Co-Pilot'),(10,3,'CabinCrew'),
(12,4,'Pilot'),(13,4,'Co-Pilot'),(14,4,'CabinCrew'),
(16,5,'Pilot'),(17,5,'Co-Pilot'),(18,5,'CabinCrew');


-- Insert sample data into the DelayRecord table
INSERT INTO DelayRecord (flight_id, delay_minutes, reason) VALUES
(3,60,'Weather'),
(6,30,'Technical'),
(12,45,'Traffic'),
(17,20,'Crew Delay'),
(1,10,'Minor Issue'),
(2,15,'Weather'),
(4,5,'ATC'),
(5,25,'Maintenance'),
(7,35,'Weather'),
(8,40,'Technical');


-- Insert sample data into the Engineer table
INSERT INTO Engineer (name, specialization, certified_since) VALUES
('Ahsan Rahman','Aircraft Engine','2015-06-15'),
('Mehedi Hasan','Avionics Systems','2016-08-20'),
('Tanvir Islam','Structural Engineering','2014-03-10'),
('Rakib Hossain','Electrical Systems','2017-11-05'),
('Fahad Karim','Hydraulic Systems','2018-02-18'),
('Sajid Ahmed','Aircraft Maintenance','2013-09-25'),
('Nadim Chowdhury','Inspection Specialist','2019-07-12'),
('Imtiaz Khan','Engine Diagnostics','2016-12-01'),
('Shahin Alam','Safety Compliance','2015-04-30'),
('Rashed Mahmud','Mechanical Systems','2017-06-22');


-- Insert sample data into the MaintenanceLog table
INSERT INTO MaintenanceLog (aircraft_id, engineer_id, start_time, end_time, type, status) VALUES
(1,1,'2026-04-10 08:00','2026-04-10 12:00','Routine','Completed'),
(2,2,'2026-04-10 09:00','2026-04-10 13:00','Inspection','Completed'),
(3,3,'2026-04-11 08:00','2026-04-11 14:00','Routine','Pending'),
(4,1,'2026-04-11 10:00','2026-04-11 15:00','Emergency','Completed'),
(5,2,'2026-04-12 08:00','2026-04-12 12:00','Routine','Pending'),
(6,3,'2026-04-12 09:00','2026-04-12 11:00','Inspection','Completed'),
(7,1,'2026-04-13 08:00','2026-04-13 12:00','Routine','Completed'),
(8,2,'2026-04-13 09:00','2026-04-13 13:00','Routine','Pending'),
(9,3,'2026-04-14 08:00','2026-04-14 12:00','Inspection','Completed'),
(10,1,'2026-04-14 10:00','2026-04-14 15:00','Routine','Pending');