import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'age.dart';

class Gender extends StatefulWidget {
  final int userId; // Add userId as a parameter

  Gender({required this.userId}); // Constructor to receive userId

  @override
  _GenderState createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  String selectedGender = '';

  Color maleButtonColor = Color(0xFFD8FC3C);
  Color femaleButtonColor = Color(0xFF2C2C2E);
  Color maleIconColor = Colors.black;
  Color femaleIconColor = Colors.white;
  Color maleTextColor = Colors.black;
  Color femaleTextColor = Colors.white;

  void _selectMale() {
    setState(() {
      selectedGender = 'male';
      maleButtonColor = Color(0xFFD8FC3C);
      femaleButtonColor = Color(0xFF2C2C2E);
      maleIconColor = Colors.black;
      femaleIconColor = Colors.white;
      maleTextColor = Colors.black;
      femaleTextColor = Colors.white;
    });
  }

  void _selectFemale() {
    setState(() {
      selectedGender = 'female';
      maleButtonColor = Color(0xFF2C2C2E);
      femaleButtonColor = Color(0xFFD8FC3C);
      maleIconColor = Colors.white;
      femaleIconColor = Colors.black;
      maleTextColor = Colors.white;
      femaleTextColor = Colors.black;
    });
  }

  Future<void> _updateGender() async {
    if (selectedGender.isNotEmpty) {
      final response = await http.put(
        Uri.parse(
            'http://localhost:8080/users/update-gender/${widget.userId}/$selectedGender'),
      );

      if (response.statusCode == 200) {
        print('Gender updated successfully');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Age(userId: widget.userId),
          ),
        );
      } else {
        print('Error updating gender: ${response.statusCode}');
        // Handle error appropriately based on your application requirements
      }
    } else {
      // Show an error message or handle the case where no gender is selected
      print('Please select a gender');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tell Us about your Self'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'To give a better experience we need to know your gender'
                        .toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                onPressed: _selectMale,
                style: ElevatedButton.styleFrom(
                  primary: maleButtonColor,
                  shape: CircleBorder(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.male,
                        color: maleIconColor,
                        size: 80.0,
                      ),
                      Text(
                        'Male',
                        style: TextStyle(
                          color: maleTextColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                onPressed: _selectFemale,
                style: ElevatedButton.styleFrom(
                  primary: femaleButtonColor,
                  shape: CircleBorder(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.female,
                        color: femaleIconColor,
                        size: 80.0,
                      ),
                      Text(
                        'Female',
                        style: TextStyle(
                          color: femaleTextColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0, right: 10.0),
                child: ElevatedButton(
                  onPressed: _updateGender,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFD8FC3C),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      10.0,
                      10.0,
                      0.0,
                      10.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Next ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
