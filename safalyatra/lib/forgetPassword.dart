import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Container(
        color: Color.fromRGBO(247, 238, 221, 1), // Background color set to RGB(247, 238, 221)
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Perform forget password functionality here
                    String email = _emailController.text;
                    // You can add your forget password logic here
                    
                    // Show a message or navigate to a confirmation page
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Forget password link sent to $email')),
                    );
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
