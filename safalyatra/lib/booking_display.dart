import 'package:flutter/material.dart';
import 'package:safalyatra/form.dart';

class BookingDisplayPage extends StatefulWidget {
  final BookingFormData formData; // Receive form data

  BookingDisplayPage({required this.formData});

  @override
  _BookingDisplayPageState createState() => _BookingDisplayPageState();
}

class _BookingDisplayPageState extends State<BookingDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booked Hotel Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Name: ${widget.formData.userName}'),
            Text('User Email: ${widget.formData.userEmail}'),
            Text('User Phone: ${widget.formData.userPhone}'),
            Text('Hotel Name: ${widget.formData.hotelName}'),
            Text('Room Type: ${widget.formData.roomType}'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _editFormData();
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _deleteFormData();
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to edit the booked hotel form
  void _editFormData() {
    // Navigate to the form page with the current form data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HotelBookingForm(formData: widget.formData)),
    );
  }

  // Function to delete the booked hotel form
  void _deleteFormData() {
    // Implement delete functionality here, for example:
    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this booking?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform the delete operation
                // For demonstration, just pop the page here
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the booking display page
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
