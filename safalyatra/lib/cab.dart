import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CabPage extends StatelessWidget {
  //
  final List<Cab> cabList = [
    Cab(
      name: 'SwiftRide',
      details: 'Details for Cab ',
      rating: 4.5,
      carNumber: 123,
      driverName: 'Ram',
      licenseNumber: '123456',
      driverAddress: '123 Main St, City',
      contactNumber: '+1234567890',
    ),
    Cab(
      name: 'TurboCruise',
      details: 'Details for Cab ',
      rating: 4.2,
      carNumber: 456,
      driverName: 'Shyam',
      licenseNumber: '789012',
      driverAddress: '456 Elm St, Town',
      contactNumber: '+0987654321',
    ),
    Cab(
      name: 'SpeedyCab',
      details: 'Details for Cab ',
      rating: 4.7,
      carNumber: 789,
      driverName: 'Johnson',
      licenseNumber: '345678',
      driverAddress: '789 Oak St, Village',
      contactNumber: '+1357924680',
    ),
    Cab(
      name: 'Rapid Transit',
      details: 'Details for Cab ',
      rating: 4.6,
      carNumber: 567,
      driverName: 'Martinez',
      licenseNumber: '678901',
      driverAddress: '567 Spruce St, Ward',
      contactNumber: '+5824691370',
    ),
    // Add details for other cabs similarly
    Cab(
      name: 'SwiftStream',
      details: 'Details for Cab ',
      rating: 4.1,
      carNumber: 012,
      driverName: 'Bob ',
      licenseNumber: '678901',
      driverAddress: '012 Pine St, County',
      contactNumber: '+2468013579',
    ),
    Cab(
      name: 'RapidRunner',
      details: 'Details for Cab ',
      rating: 4.8,
      carNumber: 345,
      driverName: 'Hari',
      licenseNumber: '901234',
      driverAddress: '345 Cedar St, Hamlet',
      contactNumber: '+9876543210',
    ),
    Cab(
      name: 'ThrustTaxi',
      details: 'Details for Cab ',
      rating: 4.6,
      carNumber: 567,
      driverName: 'Dipak',
      licenseNumber: '678901',
      driverAddress: '567 Spruce St, Ward',
      contactNumber: '+5824691370',
    ),
    Cab(
      name: 'LightningRider',
      details: 'Details for Cab ',
      rating: 4.3,
      carNumber: 678,
      driverName: 'Lokesh',
      licenseNumber: '234567',
      driverAddress: '678 Maple St, Borough',
      contactNumber: '+3692581470',
    ),
    Cab(
      name: 'FlashFleet',
      details: 'Details for Cab ',
      rating: 4.9,
      carNumber: 901,
      driverName: 'sujal',
      licenseNumber: '456789',
      driverAddress: '901 Walnut St, District',
      contactNumber: '+7531592648',
    ),
    Cab(
      name: 'DashRide',
      details: 'Details for Cab ',
      rating: 4.6,
      carNumber: 567,
      driverName: 'Linda Martinez',
      licenseNumber: '678901',
      driverAddress: '567 Spruce St, Ward',
      contactNumber: '+5824691370',
    ),
    Cab(
      name: 'Speedstercab',
      details: 'Details for Cab ',
      rating: 4.4,
      carNumber: 234,
      driverName: 'Dilip',
      licenseNumber: '567890',
      driverAddress: '234 Birch St, Precinct',
      contactNumber: '+1478523690',
    ),
    Cab(
      name: 'RushRover',
      details: 'Details for Cab ',
      rating: 4.6,
      carNumber: 567,
      driverName: 'raj',
      licenseNumber: '678901',
      driverAddress: '567 Spruce St, Ward',
      contactNumber: '+5824691370',
    ),
    Cab(
      name: 'Expressway',
      details: 'Details for Cab ',
      rating: 4.6,
      carNumber: 897,
      driverName: 'prabesh',
      licenseNumber: '678901',
      driverAddress: '567 Spruce St, Ward',
      contactNumber: '+5824691370',
    ),
    Cab(
      name: 'QuickWheels',
      details: 'Details for Cab ',
      rating: 4.0,
      carNumber: 890,
      driverName: 'rajesh hamal ',
      licenseNumber: '789012',
      driverAddress: '890 Oak St, Circuit',
      contactNumber: '+3691472580',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cabs'),
      ),
      body: ListView.builder(
        itemCount: cabList.length,
        itemBuilder: (context, index) {
          final cab = cabList[index];
          return ListTile(
            title: Text(cab.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CabDetailsPage(cab: cab)),
              );
            },
          );
        },
      ),
    );
  }
}

class Cab {
  final String name;
  final String details;
  final double rating;
  final int carNumber;
  final String driverName;
  final String licenseNumber;
  final String driverAddress;
  final String contactNumber;

  Cab({
    required this.name,
    required this.details,
    required this.rating,
    required this.carNumber,
    required this.driverName,
    required this.licenseNumber,
    required this.driverAddress,
    required this.contactNumber,
  });
}

class CabDetailsPage extends StatelessWidget {
  final Cab cab;

  const CabDetailsPage({Key? key, required this.cab}) : super(key: key);

  // Method to handle booking action
  Future<void> _bookCab(BuildContext context) async {
    final url = Uri.parse("http://192.168.41.71:4001/cab/book/");
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'driverName': cab.driverName,
          'carNumber': cab.carNumber,
        }),
      );

      if (response.statusCode == 201) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Booking Successful'),
              content: Text(
                  'You have successfully booked ${cab.driverName} with car number ${cab.carNumber}.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        throw Exception('Failed to book cab. Please try again later.');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Booking Error'),
            content: Text('An error occurred while booking cab. $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cab.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 8),
            Text('Rating: ${cab.rating}'),
            Text('Car Number: ${cab.carNumber}'),
            Text('Driver Name: ${cab.driverName}'),
            Text('License Number: ${cab.licenseNumber}'),
            Text('Driver Address: ${cab.driverAddress}'),
            Text('Contact Number: ${cab.contactNumber}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _bookCab(context),
              child: Text('Book'),
            ),
          ],
        ),
      ),
    );
  }
}
