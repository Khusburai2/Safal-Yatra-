import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  Future<void> createProfile() async {
    final response = await http.post(
      Uri.parse('http://192.168.41.71:4001/profile/create'),
      body: {
        'name': _nameController.text,
        'email': _emailController.text,
        'address': _addressController.text,
      },
    );
    if (response.statusCode == 200) {
      // Navigate to the profile details page after successful creation
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileDetailsPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create profile'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: createProfile,
              child: Text('Create Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch profile data from backend and display it here
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Details'),
      ),
      body: Center(
        child: Text('Profile Details Page'),
      ),
    );
  }
}
