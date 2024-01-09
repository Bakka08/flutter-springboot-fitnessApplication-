import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../afterlogin.dart';

class ActivityLevel extends StatefulWidget {
  final int userId; // Add userId as a parameter

  ActivityLevel({required this.userId}); // Constructor to receive userId

  @override
  _ActivityLevelState createState() => _ActivityLevelState();
}

class _ActivityLevelState extends State<ActivityLevel> {
  int selectedActivityLevel = 3; // Set 1 as the default selected activity level
  FixedExtentScrollController scrollController =
      FixedExtentScrollController(initialItem: 3 - 1);

  Map<int, String> activityLevels = {
    1: "BMR",
    2: "little or no exercise",
    3: "Exercise 1-3 times/week",
    4: "Exercise 4-5 times/week",
    5: "Exercise 5-6 times/week",
    6: "Exercise 6-7 times/week",
    7: "physical job",
  };

  Future<void> _updateActivityLevel() async {
    final response = await http.put(
      Uri.parse(
          'http://localhost:8080/users/update-activity-level/${widget.userId}/$selectedActivityLevel'),
    );

    if (response.statusCode == 200) {
      print('Activity level updated successfully');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Afterlogin(userId: widget.userId),
        ),
      );
    } else {
      print('Error updating activity level: ${response.statusCode}');
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
                    'Your regular activity level'.toUpperCase(),
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
                  activityLevels.length,
                  (index) {
                    int level = index + 1;
                    return Center(
                      child: Text(
                        level == selectedActivityLevel
                            ? activityLevels[level]!
                            : activityLevels[level]!,
                        style: TextStyle(
                          color: level == selectedActivityLevel
                              ? Color(0xFFD8FC3C) // Selected color
                              : Colors.white,
                          fontSize:
                              level == selectedActivityLevel ? 30.0 : 20.0,
                        ),
                      ),
                    );
                  },
                ),
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedActivityLevel = index + 1;
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
                      Navigator.pop(context);
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
                    onPressed: _updateActivityLevel,
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
