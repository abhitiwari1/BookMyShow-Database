CREATE DATABASE Book_MyShow;
USE Book_MyShow;
CREATE TABLE Users(
	user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(50)NOT NULL,
    age INT NOT NULL,
    user_password VARCHAR(10) NOT NULL,
    phone_number VARCHAR(10),
    address VARCHAR(100),
    created_at TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO Users (user_name, email, age, user_password, phone_number, address)
VALUES
('JohnDoe', 'john@example.com', 30, 'password1', '1234567890', '123 Main St, City A'),
('JaneSmith', 'jane@example.com', 28, 'password2', '0987654321', '456 Oak St, City B'),
('AliceBrown', 'alice@example.com', 35, 'password3', '1122334455', '789 Pine St, City C'),
('BobWhite', 'bob@example.com', 32, 'password4', '2233445566', '101 Maple St, City D'),
('CharlieBlack', 'charlie@example.com', 40, 'password5', '3344556677', '202 Birch St, City E');


CREATE TABLE Location(
    state VARCHAR(25) NOT NULL,
    district VARCHAR (25) NOT NULL,
    pin_code VARCHAR (6) PRIMARY KEY ,
    address VARCHAR(50) NOT NULL
);
INSERT INTO Location (state, district, pin_code, address)
VALUES
('California', 'Los Angeles', '90001', '123 Hollywood Blvd'),
('Texas', 'Houston', '77001', '456 Main St'),
('New York', 'Manhattan', '10001', '789 5th Ave'),
('Florida', 'Miami', '33101', '101 Ocean Dr'),
('Illinois', 'Chicago', '60601', '202 State St');


CREATE TABLE Movies(
	movie_id INT AUTO_INCREMENT PRIMARY KEY,
	movie_name VARCHAR(50) UNIQUE,
    description VARCHAR(200),
    movie_duration TIME NOT NULL,
    genre ENUM('Comedy', 'Thriller', 'Action', 'Sci-Fi', 'Horror', 'Romance', 'Documentary'),
    movie_language ENUM('Hindi', 'English', 'Tamil', 'Telugu', 'Malayalam'),
    release_date DATE NOT NULL,
    rating DECIMAL (10,1),
    cast VARCHAR(100)
);
INSERT INTO Movies (movie_name, description, movie_duration, genre, movie_language, release_date, rating, cast)
VALUES
('Inception', 'A mind-bending thriller about dreams within dreams.', '02:28:00', 'Sci-Fi', 'English', '2010-07-16', 8.8, 'Leonardo DiCaprio, Joseph Gordon-Levitt'),
('Parasite', 'A dark comedy exploring class divides.', '02:12:00', 'Thriller', 'Tamil', '2019-05-30', 8.6, 'Song Kang-ho, Lee Sun-kyun'),
('3 Idiots', 'A comedy about friendship and chasing dreams.', '02:50:00', 'Comedy', 'Hindi', '2009-12-25', 8.4, 'Aamir Khan, Kareena Kapoor'),
('The Conjuring', 'A horror movie based on real events.', '01:52:00', 'Horror', 'English', '2013-07-19', 7.5, 'Vera Farmiga, Patrick Wilson'),
('Kumbalangi Nights', 'A touching romance set in a small town.', '02:15:00', 'Romance', 'Malayalam', '2019-02-07', 8.6, 'Shane Nigam, Fahadh Faasil');


CREATE TABLE Theater(
	theater_id INT AUTO_INCREMENT PRIMARY KEY,
    theater_name VARCHAR(20) NOT NULL,
    total_screen INT NOT NULL,
    theater_type ENUM('Multiplex', 'Single Screen'),
    pin_code VARCHAR(6) NOT NULL,
    city VARCHAR(50),
    region VARCHAR(50),
    longitude DECIMAL(10,2),
    latitude DECIMAL(10,2),
    FOREIGN KEY(pin_code) REFERENCES Location(pin_code)
);
INSERT INTO Theater (theater_name, total_screen, theater_type, pin_code, city, region, longitude, latitude)
VALUES
('Cineplex', 5, 'Multiplex', '90001', 'Los Angeles', 'California', -118.25, 34.05),
('Grand Cinema', 3, 'Single Screen', '77001', 'Houston', 'Texas', -95.36, 29.76),
('Regal Movies', 10, 'Multiplex', '10001', 'New York', 'New York', -73.99, 40.75),
('Sunshine Theater', 2, 'Single Screen', '60601', 'Chicago', 'Illinois', -87.63, 41.88),
('Oceanview Cinemas', 8, 'Multiplex', '33101', 'Miami', 'Florida', -80.19, 25.77);


CREATE TABLE Screen(
	screen_id INT AUTO_INCREMENT PRIMARY KEY,
    screen_name VARCHAR(20) UNIQUE,
    total_seats INT NOT NULL,
    theater_id INT NOT NULL,
    FOREIGN KEY(theater_id) REFERENCES Theater(theater_id) ON DELETE CASCADE
);
INSERT INTO Screen (screen_name, total_seats, theater_id)
VALUES
('Screen 1', 150, 1),
('Screen 2', 200, 1),
('Screen 3', 120, 2),
('Screen 4', 250, 3),
('Screen 5', 180, 4);


CREATE TABLE Show_(
	show_id INT AUTO_INCREMENT PRIMARY KEY,
    show_start_time TIME,
    show_end_time TIME,
    show_date DATE,
    show_status VARCHAR(10) NOT NULL,
    movie_id INT,
    theater_id INT,
    screen_id INT,
    FOREIGN KEY(movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY(theater_id) REFERENCES Theater(theater_id),
    FOREIGN KEY(screen_id) REFERENCES Screen(screen_id)
);
INSERT INTO Show_ (show_start_time, show_end_time, show_date, show_status, movie_id, theater_id, screen_id)
VALUES
('15:00:00', '17:30:00', '2024-09-20', 'Scheduled', 1, 1, 1),
('18:00:00', '20:30:00', '2024-09-20', 'Scheduled', 2, 1, 2),
('21:00:00', '23:15:00', '2024-09-20', 'Scheduled', 3, 2, 3),
('12:00:00', '14:30:00', '2024-09-21', 'Scheduled', 4, 3, 4),
('16:00:00', '18:15:00', '2024-09-21', 'Scheduled', 5, 4, 5);


CREATE TABLE Seat(
	seat_id INT AUTO_INCREMENT PRIMARY KEY,
    number_of_seat INT UNIQUE,
    seat_type ENUM('Regular', 'VIP', 'premium'),
    seat_price DECIMAL(10,2),
    seat_row INT NOT NULL,
    seat_col INT NOT NULL, 
    screen_id INT,
    FOREIGN KEY(screen_id) REFERENCES Screen(screen_id) ON DELETE CASCADE,
    UNIQUE(seat_row, seat_col, screen_id)
);
INSERT INTO Seat (number_of_seat, seat_type, seat_price, seat_row, seat_col, screen_id)
VALUES
(1, 'Regular', 12.00, 1, 1, 1),
(2, 'VIP', 25.00, 1, 2, 1),
(3, 'Premium', 35.00, 2, 1, 1),
(4, 'Regular', 12.00, 2, 2, 2),
(5, 'VIP', 25.00, 3, 1, 2);


CREATE TABLE Booking(
	booking_id INT AUTO_INCREMENT PRIMARY KEY,
    total_amount DECIMAL(10,2) NOT NULL,
    no_of_tickets INT DEFAULT 0,
    booking_status ENUM('Pending', 'Done', 'Cancelled') DEFAULT 'Done',
    user_id INT NOT NULL,
    show_id INT NOT NULL,
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY(show_id) REFERENCES Show_(show_id) ON DELETE CASCADE
);
INSERT INTO Booking (total_amount, no_of_tickets, booking_status, user_id, show_id)
VALUES
(50.00, 2, 'Done', 1, 1),
(75.00, 3, 'Pending', 2, 2),
(30.00, 1, 'Cancelled', 3, 3),
(100.00, 4, 'Done', 4, 4),
(60.00, 2, 'Done', 5, 5);


CREATE TABLE Booking_Seat(
	booking_seat_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    seat_id INT,
    FOREIGN KEY(booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE,
    FOREIGN KEY(seat_id) REFERENCES Seat(seat_id) ON DELETE CASCADE
);
INSERT INTO Booking_Seat (booking_id, seat_id)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5);



CREATE TABLE Payment(
	payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    payment_method ENUM('Credit Card', 'Debit Card', 'Net Banking', 'UPI', 'Wallet'),
    payment_status ENUM('Pending', 'Completed', 'Refunded'),
    refund_amount DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY(booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE
);
INSERT INTO Payment (booking_id, payment_method, payment_status, refund_amount)
VALUES
(1, 'Credit Card', 'Completed', 0.00),
(2, 'Debit Card', 'Pending', 13.56),
(3, 'Net Banking', 'Refunded', 30.00),
(4, 'UPI', 'Completed', 9.00),
(5, 'Wallet', 'Completed', 0.00);

CREATE TABLE vacant_seats(
	show_id INT NOT NULL,
    seat_id INT NOT NULL,
    is_vacant BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY(show_id, seat_id),
    FOREIGN KEY(show_id) REFERENCES Show_(show_id) ON DELETE CASCADE,
    FOREIGN KEY(seat_id) REFERENCES Seat(seat_id) ON DELETE CASCADE
);
INSERT INTO vacant_seats (show_id, seat_id, is_vacant)
VALUES
(1, 1, TRUE),
(1, 2, TRUE),
(2, 3, FALSE),
(3, 4, TRUE),
(4, 5, FALSE);


CREATE TABLE Ticket(	
	ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    seat_id INT NOT NULL,
    customer_name VARCHAR(50),
    customer_age INT,
    FOREIGN KEY(booking_id) REFERENCES Booking(booking_id) ON DELETE RESTRICT,
    FOREIGN KEY(seat_id) REFERENCES Seat(seat_id) ON DELETE RESTRICT
);
INSERT INTO Ticket (booking_id, seat_id, customer_name, customer_age)
VALUES
(1, 1, 'Alice Johnson', 30),
(1, 2, 'Bob Smith', 25),
(2, 3, 'Carol Davis', 28),
(3, 4, 'David Brown', 35),
(4, 5, 'Emma Wilson', 22);


CREATE TABLE User_reviews(
	review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    theater_id INT,
    rating INT CHECK(rating BETWEEN 1 AND 10),
    review_description TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY(movie_id) REFERENCES Movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY(theater_id) REFERENCES Theater(theater_id) ON DELETE SET NULL
);
INSERT INTO User_reviews (user_id, movie_id, theater_id, rating, review_description)
VALUES
(1, 1, 1, 5, 'Amazing movie with a mind-bending plot!'),
(2, 2, 1, 4, 'Great thriller with intense moments.'),
(3, 3, 2, 3, 'Entertaining but not as impactful as I expected.'),
(4, 4, 3, 5, 'Incredible story and performance. Highly recommend!'),
(5, 5, 4, 2, 'Disappointing experience. The movie didn’t live up to the hype.');


    
CREATE TABLE Offer(
	offer_id INT AUTO_INCREMENT PRIMARY KEY,
    offer_code VARCHAR(20) UNIQUE NOT NULL,
    discount_percentage DECIMAL(10,2) NOT NULL,
    valid_from TIMESTAMP,
    valid_to TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    terms_conditions TEXT NOT NULL
);
INSERT INTO Offer (offer_code, discount_percentage, valid_from, valid_to, terms_conditions)
VALUES
('SUMMER2024', 15.00, '2024-06-01 00:00:00', '2024-08-31 23:59:59', 'Valid for summer season. Excludes special events and holidays.'),
('WINTER2024', 20.00, '2024-12-01 00:00:00', '2024-12-31 23:59:59', 'Valid for winter season. Cannot be combined with other offers.'),
('HOLIDAY10', 10.00, '2024-11-20 00:00:00', '2024-11-30 23:59:59', 'Holiday special. Valid for online bookings only.'),
('NEWYEAR2025', 25.00, '2024-12-25 00:00:00', '2025-01-10 23:59:59', 'New Year’s offer. Applies to all bookings made in December.'),
('SPRING2025', 12.50, '2025-03-01 00:00:00', '2025-05-31 23:59:59', 'Spring offer. Valid on selected dates and venues only.');

SELECT seat_type, seat_price, COUNT(*) AS total_seats
FROM Seat
GROUP BY seat_type, seat_price;

CREATE TRIGGER update_vacant_seats
AFTER INSERT ON Ticket
FOR EACH ROW
UPDATE vacant_seats
SET is_vacant = FALSE
WHERE(SELECT show_id FROM bookings WHERE booking_id = NEW.booking_id) = show_id AND seat_id = NEW.seat_id;

SELECT movie_name, release_date, rating, genre, movie_language, show_date, s.show_start_time
FROM Show_ s
JOIN Movies m ON s.show_id = m.movie_id
WHERE m.movie_name = '3 Idiots';

SELECT screen_name, total_screen, theater_name, t.theater_type, city
FROM Theater t
JOIN Screen S ON t.theater_id = S.theater_id;

SELECT user_name, age, movie_name, rating, m.genre
FROM Movies m
JOIN Users u ON m.genre = u.user_id;

SELECT movie_name, movie_language, genre, review_description, review_date
FROM User_reviews ur
JOIN Movies m ON ur.review_id = m.movie_id;

SELECT total_amount, no_of_tickets, booking_status, booking_time, user_name, age
FROM Booking b
JOIN Users u ON b.booking_id = u.user_id;

SELECT total_amount, no_of_tickets, booking_status, payment_method, payment_status, refund_amount
FROM Payment py
JOIN Booking b ON py.payment_id = b.booking_id;

SELECT customer_name, customer_age, offer_code, discount_percentage, terms_conditions
FROM Ticket ti
JOIN Offer o ON ti.ticket_id = o.offer_id;

SELECT screen_name, number_of_seat, seat_type, seat_price, seat_row, seat_col
FROM Screen S 
JOIN Seat se ON S.screen_id = se.seat_id;

SELECT state, district, theater_name, th.theater_type, th.city
FROM Location l
JOIN Theater th ON l.district = th.theater_name;

SELECT customer_name 
FROM Ticket
WHERE customer_age BETWEEN 20 AND 30;

SELECT is_vacant 
FROM vacant_seats
WHERE is_vacant = False;

SELECT payment_method, payment_status
FROM Payment
WHERE refund_amount BETWEEN 10 AND 30;   

UPDATE Ticket
SET customer_name = 'John Doe', customer_age = 35
WHERE seat_id = 2; 
    
UPDATE Payment
SET payment_method = 'UPI'
WHERE payment_status = 'Refunded';

SELECT customer_name
FROM Ticket
WHERE customer_age > 20;

DELETE FROM Offer
WHERE offer_code = 'WINTER2024';

SELECT screen_name
FROM Screen
ORDER BY total_seats ASC;

SELECT theater_name, COUNT(*)
FROM Theater
GROUP BY theater_name
HAVING theater_name = 'Multiplex'  AND COUNT(*) > 2;

SELECT no_of_tickets
FROM Booking
ORDER BY total_amount DESC
LIMIT 3;

SELECT DISTINCT seat_type
FROM Seat;
    