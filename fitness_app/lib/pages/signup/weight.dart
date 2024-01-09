import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'height.dart';

class Weight extends StatefulWidget {
  final int userId; // Add userId as a parameter

  Weight({required this.userId}); // Constructor to receive userId

  @override
  _WeightState createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  double selectedWeight = 50.0; // Set 50.0 as the default selected weight

  Future<void> _updateWeight() async {
    final response = await http.put(
      Uri.parse(
          'http://localhost:8080/users/update-weight/${widget.userId}/$selectedWeight'),
    );

    if (response.statusCode == 200) {
      print('Weight updated successfully');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Height(userId: widget.userId),
        ),
      );
    } else {
      print('Error updating weight: ${response.statusCode}');
      // Handle error appropriately based on your application requirements
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
                    'What\'s your weight?'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'You can always change this later'.toUpperCase(),
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
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        selectedWeight
                            .toStringAsFixed(1), // Display one decimal place
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0, // Increased font size to 40.0
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' kg',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Color(0xFFD8FC3C),
                      inactiveTrackColor: Colors.white,
                      thumbColor: Color(0xFFD8FC3C),
                      overlayColor: Color(0x29D8FC3C),
                      valueIndicatorColor: Color(0xFFD8FC3C),
                    ),
                    child: Slider(
                      value: selectedWeight,
                      min: 40.0,
                      max: 160.0,
                      onChanged: (value) {
                        setState(() {
                          selectedWeight = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      print("Go back button pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF3A3A3C),
                      shape: CircleBorder(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  child: ElevatedButton(
                    onPressed: _updateWeight,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
