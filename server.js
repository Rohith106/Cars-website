const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
const port = 5000;

app.use(cors());
app.use(express.json());

// MySQL database connection
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'yourpassword', // Replace with your MySQL password
    database: 'CarRentalDB'
});

db.connect(err => {
    if (err) {
        console.error('Database connection failed:', err);
    } else {
        console.log('Connected to MySQL database');
    }
});

// Get all cars
app.get('/cars', (req, res) => {
    db.query('SELECT * FROM Cars WHERE availability = TRUE', (err, results) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            res.json(results);
        }
    });
});

// Get car by ID
app.get('/cars/:id', (req, res) => {
    const { id } = req.params;
    db.query('SELECT * FROM Cars WHERE car_id = ?', [id], (err, results) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else if (results.length === 0) {
            res.status(404).json({ message: 'Car not found' });
        } else {
            res.json(results[0]);
        }
    });
});

// Create a new booking
app.post('/bookings', (req, res) => {
    const { user_id, car_id, start_date, end_date, total_price } = req.body;
    const query = `INSERT INTO Bookings (user_id, car_id, start_date, end_date, total_price) VALUES (?, ?, ?, ?, ?)`;
    db.query(query, [user_id, car_id, start_date, end_date, total_price], (err, result) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            res.status(201).json({ message: 'Booking created successfully', booking_id: result.insertId });
        }
    });
});

// Get all blog posts
app.get('/blogs', (req, res) => {
    db.query('SELECT * FROM Blog', (err, results) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            res.json(results);
        }
    });
});

// Get contact details
app.get('/contact', (req, res) => {
    db.query('SELECT * FROM Contact', (err, results) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            res.json(results);
        }
    });
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
