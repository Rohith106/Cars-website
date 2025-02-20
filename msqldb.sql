-- Create database
CREATE DATABASE CarRentalDB;
USE CarRentalDB;

-- Table for storing users
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for storing car details
CREATE TABLE Cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year INT NOT NULL,
    price_per_day DECIMAL(10,2) NOT NULL,
    availability BOOLEAN DEFAULT TRUE,
    image_url VARCHAR(255) NULL
);

-- Table for bookings
CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    car_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('Pending', 'Confirmed', 'Cancelled') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (car_id) REFERENCES Cars(car_id) ON DELETE CASCADE
);

-- Table for storing blog posts
CREATE TABLE Blog (
    blog_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for contact details
CREATE TABLE Contact (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    phone VARCHAR(15) NOT NULL,
    available_days VARCHAR(50) NOT NULL
);

-- Insert sample contact information
INSERT INTO Contact (phone, available_days) 
VALUES ('+91 8919223134', 'Mon - Sat: 9:00 am - 6:00 pm');

-- Sample data for testing
INSERT INTO Users (name, email, password, phone) VALUES 
('Rohith', 'rohith@example.com', 'hashedpassword', '+919876543210');

INSERT INTO Cars (brand, model, year, price_per_day, availability, image_url) VALUES
('Toyota', 'Camry', 2022, 50.00, TRUE, 'https://example.com/car1.jpg'),
('BMW', 'X5', 2023, 120.00, TRUE, 'https://example.com/car2.jpg');

INSERT INTO Blog (title, content) VALUES 
('How to Choose the Right Rental Car', 'Here are some tips on choosing the best rental car for your needs.');