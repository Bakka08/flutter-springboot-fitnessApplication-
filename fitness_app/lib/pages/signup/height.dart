import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'goal.dart';

class Height extends StatefulWidget {
  final int userId; // Add userId as a parameter

  Height({required this.userId}); // Constructor to receive userId

  @override
  _HeightState createState() => _HeightState();
}

class _HeightState extends State<Height> {
  int selectedHeight = 170; // Set 170 as the default selected height
  FixedExtentScrollController scrollController =
      FixedExtentScrollController(initialItem: 170 - 130);

  Future<void> _updateHeight() async {
    final response = await http.put(
      Uri.parse(
          'http://localhost:8080/users/update-height/${widget.userId}/$selectedHeight'),
    );

    if (response.statusCode == 200) {
      print('Height updated successfully');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Goal(userId: widget.userId),
        ),
      );
    } else {
      print('Error updating height: ${response.statusCode}');
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
                    'What\'s your height?'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'This helps us create your personalized plan'.toUpperCase(),
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
            child: Center(
              child: ListWheelScrollView(
                controller: scrollController,
                itemExtent: 80.0, // Height of each item
                physics: FixedExtentScrollPhysics(),
                children: List.generate(
                  101, // 230 - 130 + 1
                  (index) {
                    int height = 130 + index;
                    return Center(
                      child: Text(
                        height == selectedHeight ? '$height cm' : '$height',
                        style: TextStyle(
                          color: height == selectedHeight
                              ? Color(0xFFD8FC3C) // Selected color
                              : Colors.white,
                          fontSize: height == selectedHeight ? 50.0 : 25.0,
                        ),
                      ),
                    );
                  },
                ),
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedHeight = 130 + index;
                  });
                },
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
                    onPressed: _updateHeight,
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
