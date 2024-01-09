import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workout_app/pages/afterlogin.dart';
import 'signup/signup.dart';

var userId = 0;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    final String apiUrl = 'http://localhost:8080/users/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'email': emailController.text,
            'password': passwordController.text,
          },
        ),
      );

      if (response.statusCode == 200) {
        // Successful login
        final userIdFromResponse = int.tryParse(response.body);
        if (userIdFromResponse != null) {
          setState(() {
            userId = userIdFromResponse;
          });

          // Navigate to the Afterlogin screen and pass the userId
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Afterlogin(userId: userId),
            ),
          );
        } else {
          _showErrorDialog("Invalid response from server");
        }
      } else {
        // Login failed
        _showErrorDialog("Invalid email or password");
      }
    } catch (e) {
      _showErrorDialog("Error occurred during login");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF1C1C1E),
        child: Column(
          children: [
            Expanded(
              flex: 6,
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
                      'Welcome to Dev Muscles',
                      style: TextStyle(
                        color: Color(0xFFD8FC3C),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Sign in to continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Lower space with flex 4
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Email Input
                    Container(
                      margin: EdgeInsets.only(top: 30),
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

                    // Password Input
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
                          padding: EdgeInsets.only(
                              right:
                                  8), // Adjusted padding to move the icon left
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

                    // Sign In Button
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate email and password
                          if (emailController.text.isEmpty ||
                              !RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                  .hasMatch(emailController.text)) {
                            _showErrorDialog("Invalid email format");
                          } else if (passwordController.text.length < 5) {
                            _showErrorDialog(
                                "Password must be at least 5 characters");
                          } else {
                            // Perform login
                            _login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFD8FC3C),
                          onPrimary: Color(0xFF1C1C1E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 28,
                            horizontal: 12,
                          ),
                        ),
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: Color(0xFF1C1C1E),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    // Row with "Don't have an account?" and "Register" texts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                          child: Text(
                            "Register",
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
