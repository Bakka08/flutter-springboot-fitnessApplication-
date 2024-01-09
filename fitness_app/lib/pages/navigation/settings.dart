// settings.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../signup/gender.dart';
import '../login.dart';

class Settings extends StatefulWidget {
  final int userId;

  Settings({required this.userId});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      appBar: null,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Color(0xFF1C1C1E),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Icon(
                        Icons.account_circle,
                        size: 130,
                        color: Color(0xFFA4DC5D),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                flex: 1,
                child: Container(
                  color: Color(0xFF1C1C1E),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: oldPasswordController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Old Password',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: newPasswordController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                flex: 1,
                child: Container(
                  color: Color(0xFF1C1C1E),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            String oldPassword = oldPasswordController.text;
                            String newPassword = newPasswordController.text;

                            if (oldPassword.isEmpty || newPassword.isEmpty) {
                              // Show alert for empty fields
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Error'),
                                  content: Text(
                                      'Please fill in both Old Password and New Password.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }

                            // Perform HTTP request to update the password
                            Uri url = Uri.parse(
                                'http://localhost:8080/users/update-password/${widget.userId}/$oldPassword/$newPassword');
                            var response = await http.put(url);

                            // Handle the response and show an alert
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Password Update'),
                                content: Text(response.body),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      oldPasswordController.clear();
                                      newPasswordController.clear();
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: Text(
                            'Update Password',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the Gender screen with userId
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Gender(userId: widget.userId),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                          ),
                          child: Text(
                            'Update Personal Information',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the Login screen
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFA4DC5D),
                          ),
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
