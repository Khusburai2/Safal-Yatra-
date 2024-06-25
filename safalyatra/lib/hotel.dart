import 'package:flutter/material.dart';
import 'form.dart'; // Importing the form.dart file

class HotelPage extends StatelessWidget {
  // Dummy list of hotels with image file names
  final List<Map<String, dynamic>> hotelList = [
    {
      'name': 'Hotel ABC',
      'image': 'hotel1.jpeg',
      'rating': 4.5,
    },
    {
      'name': 'Hotel Jag',
      'image': 'hotel2.jpeg',
      'rating': 4.0,
    },
    {
      'name': 'Hotel Everest',
      'image': 'hotel3.jpeg',
      'rating': 4.2,
    },
    {
      'name': 'Hotel Mouleum',
      'image': 'hotel4.jpeg',
      'rating': 3.8,
    },
    {
      'name': 'Hotel Mugu',
      'image': 'hotel5.jpeg',
      'rating': 4.7,
    },
    {
      'name': 'Hotel Low',
      'image': 'hotel6.jpeg',
      'rating': 4.1,
    },
    {
      'name': 'Hotel iathari',
      'image': 'hotel7.jpeg',
      'rating': 4.3,
    },
    {
      'name': 'Hotel log',
      'image': 'hotel8.jpeg',
      'rating': 4.6,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels'),
      ),
      body: Container(
        color: Color.fromRGBO(
          247,
          238,
          221,
          1,
        ), // Background color set to RGB(247, 238, 221)
        padding: EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Reduced the number of columns to 2
            crossAxisSpacing: 16.0, // Spacing between columns
            mainAxisSpacing: 16.0, // Spacing between rows
          ),
          itemCount: hotelList.length,
          itemBuilder: (context, index) {
            final hotel = hotelList[index];
            final assetPath = 'Assets/${hotel['image']}';
            return GestureDetector(
              onTap: () {
                // Add functionality to handle when a hotel is tapped
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Image.asset(
                          assetPath, // Asset path using Uri class
                          fit: BoxFit.cover, // Image fit
                          height: double
                              .infinity, // Make image fill the available space
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          right: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotel['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0, // Reduced font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2.0), // Reduced spacing
                              Text(
                                'Rating: ${hotel['rating']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0, // Reduced font size
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HotelBookingForm(), // Navigate to the form page
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0), // Reduced padding
                    ),
                    child: Text(
                      'Book',
                      style: TextStyle(fontSize: 12.0), // Reduced font size
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
