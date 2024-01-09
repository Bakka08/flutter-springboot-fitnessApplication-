import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../login.dart';
import 'gender.dart';

// Create a variable named userId with a default value of 2
var userId = 2;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;

  void _showErrorAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleSignUp() async {
    // Read input values
    String fullName = fullNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Check if any field is empty
    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showErrorAlert('All fields are required.');
      return;
    }

    // Check if the email format is valid
    if (!RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      _showErrorAlert('Invalid email format.');
      return;
    }

    // Check if the password matches the confirm password
    if (password != confirmPassword) {
      _showErrorAlert('Passwords do not match.');
      return;
    }

    // Check if the password is at least 5 characters long
    if (password.length < 5) {
      _showErrorAlert('Password should be at least 5 characters long.');
      return;
    }

    // Prepare the request body
    Map<String, String> requestBody = {
      "fullname": fullName,
      "email": email,
      "password": password,
    };

    // Send HTTP POST request
    final response = await http.post(
      Uri.parse('http://localhost:8080/users/signup'),
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    // Check the status code of the response
    if (response.statusCode == 200) {
      // Parse the response body
      dynamic responseBody = jsonDecode(response.body);

      // Check if the response is an integer (direct userId)
      if (responseBody is int) {
        // Update the global userId variable
        setState(() {
          userId = responseBody;
        });
      } else if (responseBody is Map<String, dynamic>) {
        // Extract userId from the response and convert it to an integer
        var userIdFromResponse = responseBody['userId'];

        // Check if userIdFromResponse is an integer
        if (userIdFromResponse is int) {
          // Update the global userId variable
          setState(() {
            userId = userIdFromResponse;
          });
        } else {
          // Handle the case where userIdFromResponse is not an integer
          print('Error: userIdFromResponse is not an integer');
        }
      } else {
        // Handle the case where the response is neither an integer nor a map
        print('Error: Unexpected response format');
      }

      // Navigate to the Gender screen and pass the userId
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Gender(userId: userId),
        ),
      );
    } else {
      // Show an error message or handle the error response
      print('Error: ${response.statusCode}');
      print('Response: ${response.body}');
      // Handle error appropriately based on your application requirements
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF1C1C1E),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/LoginLogo.png',
                      width: 130,
                      height: 130,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Let's Get Started",
                      style: TextStyle(
                        color: Color(0xFFD8FC3C),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Create a new account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: TextFormField(
                        controller: fullNameController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon:
                              Icon(Icons.person_outline, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 12,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: TextFormField(
                        controller: emailController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'Your Email',
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon:
                              Icon(Icons.mail_outline, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 12,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey),
                        prefixIcon:
                            Icon(Icons.lock_outline, color: Colors.grey),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 12,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      obscureText: !_isPasswordVisible,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: confirmPasswordController,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.grey),
                        prefixIcon:
                            Icon(Icons.lock_outline, color: Colors.grey),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 12,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      obscureText: !_isPasswordVisible,
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleSignUp,
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFD8FC3C),
                          onPrimary: Color(0xFF1C1C1E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 12,
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFF1C1C1E),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              color: Color(0xFFD8FC3C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
