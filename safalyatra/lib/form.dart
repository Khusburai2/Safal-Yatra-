import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Import the BookingDisplayPage
import 'booking_display.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Booking Form',
      home: HotelBookingForm(),
    );
  }
}

class HotelBookingForm extends StatefulWidget {
  // Add a parameter to accept formData
  final BookingFormData? formData;

  HotelBookingForm({this.formData});

  @override
  _HotelBookingFormState createState() => _HotelBookingFormState();
}

class _HotelBookingFormState extends State<HotelBookingForm> {
  final _formKey = GlobalKey<FormState>();
  late String _userName;
  late String _userEmail;
  late String _userPhone;
  late String _hotelName;
  late String? _roomType;

  @override
  void initState() {
    super.initState();
    // Initialize form fields with formData if available
    if (widget.formData != null) {
      _userName = widget.formData!.userName;
      _userEmail = widget.formData!.userEmail;
      _userPhone = widget.formData!.userPhone;
      _hotelName = widget.formData!.hotelName;
      _roomType = widget.formData!.roomType;
    } else {
      _userName = '';
      _userEmail = '';
      _userPhone = '';
      _hotelName = '';
      _roomType = null;
    }
  }

  // Function to handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Create an instance of BookingFormData with the form data
      final formData = BookingFormData(
        userName: _userName,
        userEmail: _userEmail,
        userPhone: _userPhone,
        hotelName: _hotelName,
        roomType: _roomType!,
      );

      // Navigate to the booking display page and pass the form data
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookingDisplayPage(formData: formData)),
      );
    }
  }

  Future<void> _bookHotel() async {
    final url = Uri.parse("http://192.168.41.71:4001/api/submit-form");

    final formData = {
      'userName': _userName,
      'userEmail': _userEmail,
      'userPhone': _userPhone,
      'hotelName': _hotelName,
      'roomType': _roomType,
    };

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(formData),
      );
      print(response);
      if (response.statusCode == 201) {
        _showDialog('Hotel booked successfully!');
        _submitForm(); // Call _submitForm() after booking successfully
      } else {
        _showDialog('Failed to book hotel. Please try again later.');
      }
    } catch (e) {
      _showDialog('An error occurred. Please try again later.');
    }
  }

  Future<void> _showDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Status'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel Booking Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                initialValue: _userName, // Initialize with existing value
                decoration: InputDecoration(labelText: 'Your Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userName = value!;
                },
              ),
              TextFormField(
                initialValue: _userEmail, // Initialize with existing value
                decoration: InputDecoration(labelText: 'Your Email'),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userEmail = value!;
                },
              ),
              TextFormField(
                initialValue: _userPhone, // Initialize with existing value
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userPhone = value!;
                },
              ),
              TextFormField(
                initialValue: _hotelName, // Initialize with existing value
                decoration: InputDecoration(labelText: 'Hotel Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter hotel name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _hotelName = value!;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Room Type'),
                value: _roomType,
                onChanged: (String? newValue) {
                  setState(() {
                    _roomType = newValue;
                  });
                },
                items: <String>['Standard', 'Deluxe', 'Suite']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _bookHotel();
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingFormData {
  final String userName;
  final String userEmail;
  final String userPhone;
  final String hotelName;
  final String roomType;

  BookingFormData({
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.hotelName,
    required this.roomType,
  });
}
