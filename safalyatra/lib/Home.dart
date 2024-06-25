import 'package:flutter/material.dart';
import 'package:safalyatra/cab.dart';
import 'package:safalyatra/hotel.dart';
import 'package:safalyatra/login.dart';
import 'package:safalyatra/profile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safal Yatra'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyLogin()),
                );
              },
            ),
            ListTile(
              title: Text('Create Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Color.fromRGBO(247, 238, 221, 1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              // Image.asset(
              //   'assets/logo.png', // Replace 'assets/logo.png' with your logo asset path
              //   height: 200, // Set the height of the logo
              // ),
              SizedBox(height: 20.0),
              AnimatedDefaultTextStyle(
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold, // Make the text bold
                  color: Colors.black, // Change the text color to black
                ),
                duration: Duration(seconds: 1), // Adjust the duration as needed
                curve: Curves.easeInOut, // Add animation curve
                child: Text(
                  'Where to Go ?',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CabPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      minimumSize: Size(150, 60),
                    ),
                    child: Row(
                      children: [
                        // Image.asset(
                        //   'assets/cab_picture.jpg', // Replace 'assets/cab_image.png' with your cab image asset path
                        //   height: 60.0, // Adjust the height of the image
                        // ),
                        SizedBox(width: 8.0),
                        Text(
                          'Cab',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20.0), // Added SizedBox for spacing
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HotelPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      minimumSize: Size(150, 60),
                    ),
                    child: Row(
                      children: [
                        // Image.asset(
                        //   'assets/hotel_picture.jpeg', // Replace 'assets/hotel_image.png' with your hotel image asset path
                        //   height: 60.0, // Adjust the height of the image
                        // ),
                        SizedBox(width: 8.0),
                        Text(
                          'Hotel',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
