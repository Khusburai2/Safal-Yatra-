const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const db = require('./db'); // Import the db connection object
const http = require('http');
// const server = http.createServer(app);

// Signup route
// Signup route
router.post('/signup', async (req, res) => {
  const { name, email, password, confirmPassword } = req.body;
  console.log(name, email, password, confirmPassword);

  try {
    if (!name || !email || !password || !confirmPassword) {
      return res.status(400).send("Please fill all the fields");
    }

    if (password !== confirmPassword) {
      return res.status(401).send("Password doesn't match");
    }

    if (email.split("@").length === 1) {
      return res.status(404).send('Please enter a valid email');
    }

    const hash = await bcrypt.hash(password, 10);
    // Assuming connection is defined somewhere
    db.query("INSERT INTO signup (name, email, password) VALUES(?,?,?)", [name, email, hash], function (err, data) {
      if (err) {
        console.error('Error executing database query:', err);
        // Log the specific error details
        console.error('SQL error:', err.sql);
        console.error('SQL error code:', err.code);
        console.error('SQL error message:', err.message);
        return res.status(500).send("Error executing database query");
      }
      console.log("User Successfully Registered");
      res.status(201).send("User successfully registered");
    });
  } catch (error) {
    console.error("An error occurred:", error);
    res.status(500).send("An error occurred");
  }
});


// Login route
router.post('/login', async (req, res) => {
  const { email, password } = req.body;
  const sql = 'SELECT * FROM signup WHERE email = ?';
  db.query(sql, [email], async (err, result) => {
    if (err) {
      console.error('Error finding user:', err);
      return res.status(500).json({ error: 'Login failed' });
    }
    if (result.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    const user = result[0];
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return res.status(401).json({ error: 'Invalid password' });
    }

    res.status(200).json({ message: 'Login successful' });
  });
});

router.post('/api/submit-form', (req, res) => {
  const { userName, userEmail, userPhone, hotelName, roomType } = req.body;

  const sql = `INSERT INTO hotelbook (userName, userEmail, userPhone, hotelName, roomType) VALUES (?, ?, ?, ?, ?)`;
  const values = [userName, userEmail, userPhone, hotelName, roomType];

  db.query(sql, values, (error, results) => {
    if (error) {
      console.error('Error inserting data into database:', error);
      res.status(500).json({ error: 'An error occurred while processing your request' });
    } else {
      console.log('Data inserted successfully:', results);
      res.status(201).json({ message: 'Form data submitted successfully' });
    }
  });
});

router.post('/cab/book', async (req, res) => {
  const { driverName, carNumber } = req.body;
  const sql = 'INSERT into bookings(driverName,carNumber) VALUES (?, ?)';
  const values = [driverName,carNumber];
      db.query(sql, values, (error, results) => {
        if (error) {
          console.error('Error inserting data into database:', error);
          res.status(500).json({ error: 'An error occurred while processing your request' });
        } else {
          console.log('Data inserted successfully:', results);
          res.status(201).json({ message: 'Form data submitted successfully' });
        }
      });
    });

   
 
  // Endpoint to create a new profile
router.post('/profile/create', async (req, res) => {
  const { name, email, address } = req.body;
 // Insert profile data into the database
  const sql = 'INSERT INTO profiledata (name, email, address) VALUES (?, ?, ?)';
  const values = [name,email,address];
  db.query(sql, values, (error, results) => {
    if (error) {
      console.error('Error creating profile:', error);
      res.status(500).json('Error creating profile');
      
    } else{ 
    console.log('Profile created:', results);
    res.status(201).json('Profile created successfully');
    }
  });
});

// Endpoint to retrieve profile details
router.get('/profile/details', (req, res) => {
  // Retrieve all profile data from the database
  const sql = 'SELECT * FROM profiledata';
  db.query(sql, (err, results) => {
    if (err) {
      console.error('Error retrieving profile details:', err);
      res.status(500).send('Error retrieving profile details');
      return;
    }
    console.log('Profile details retrieved:', results);
    res.status(200).json(results);
  });
});

  
module.exports = router;

// Create an instance of Express
const app = express();

// Use the router
app.use(express.json()); // Middleware to parse JSON bodies
app.use('/', router);

// Start the server
const PORT = process.env.PORT || 4001;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
