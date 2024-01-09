import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'activitylevel.dart';

class Goal extends StatefulWidget {
  final int userId; // Add userId as a parameter

  Goal({required this.userId}); // Constructor to receive userId

  @override
  _GoalState createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  String selectedGoal =
      "maintain"; // Set "maintain" as the default selected goal
  FixedExtentScrollController scrollController =
      FixedExtentScrollController(initialItem: 0);

  Map<String, String> goals = {
    "maintain": "Maintain weight",
    "mildlose": "Mild weight loss",
    "weightlose": "Weight loss",
    "extremelose": "Extreme weight loss",
    "mildgain": "Mild weight gain",
    "weightgain": "Weight gain",
    "extremegain": "Extreme weight gain",
  };

  Future<void> _updateGoal() async {
    final response = await http.put(
      Uri.parse(
          'http://localhost:8080/users/update-goal/${widget.userId}/$selectedGoal'),
    );

    if (response.statusCode == 200) {
      print('Goal updated successfully');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ActivityLevel(userId: widget.userId),
        ),
      );
    } else {
      print('Error updating goal: ${response.statusCode}');
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
                    'Select your goal'.toUpperCase(),
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
                  goals.length,
                  (index) {
                    String goalKey = goals.keys.elementAt(index);
                    return Center(
                      child: Text(
                        goalKey == selectedGoal
                            ? goals[goalKey]!
                            : goals[goalKey]!,
                        style: TextStyle(
                          color: goalKey == selectedGoal
                              ? Color(0xFFD8FC3C) // Selected color
                              : Colors.white,
                          fontSize: goalKey == selectedGoal ? 30.0 : 20.0,
                        ),
                      ),
                    );
                  },
                ),
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedGoal = goals.keys.elementAt(index);
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
                    onPressed: _updateGoal,
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
