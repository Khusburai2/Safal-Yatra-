import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:safalyatra/Home.dart';
import 'package:safalyatra/forgetPassword.dart';
import 'package:safalyatra/signup.dart';

class MyLogin extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    String url = "http://192.168.41.71:4001/login/";

    Map<String, String> loginData = {
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(loginData),
        headers: {"Content-Type": "application/json"},
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        print('User login successful');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Safal Yatra"),
            content: const Text('Login Successfully'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Handle other status codes and show appropriate error messages
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String errorMessage = responseData['message'] ??
            'An error occurred, please try again later';

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Safal Yatra'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      print('An error occurred: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Safal Yatra'),
          content: const Text('An error occurred, please try again later'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      backgroundColor:
          Color.fromRGBO(247, 238, 221, 1), // Set background color here
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Add your logo image here
            // Image.asset(
            //   'Assets/logo.png', // Path to your logo image
            //   width: 80,
            //   height: 0,
            //   fit: BoxFit.cover, // Adjust the width of the logo image as needed
            // ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email), // Icon for email
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock), // Icon for password
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(
                  context), // Call the login function when button is pressed
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgetPassword()),
                );
              },
              child: Text('Forget Password?'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: Text('Create new account?'),
            ),
          ],
        ),
      ),
    );
  }
}
