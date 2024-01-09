import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExerciseCard extends StatelessWidget {
  final String title;
  final String? imageUrl;

  ExerciseCard(this.title, {this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        leading: imageUrl != null
            ? Image.network(
                imageUrl!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }
}

class Planning extends StatefulWidget {
  final int userId;

  Planning({required this.userId});

  @override
  _PlanningState createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  List<String> exercises = [
    'Barbell Bench Press',
    'Dumbbell Bench Press',
    'Incline Bench Press',
    'Chest Flyes',
    'Deadlifts',
    'Lat Pulldowns',
    'T-Bar Rows',
    'Seated Cable Rows',
    'Military Press',
    'Lateral Raises',
    'Face Pulls',
    'Upright Rows',
    'Barbell Bicep Curls',
    'Tricep Rope Pushdowns',
    'Preacher Curls',
    'Skull Crushers',
    'Barbell Squats',
    'Leg Press',
    'Lunges',
    'Leg Extensions',
    'Planks',
    'Cable Crunches',
    'Hanging Leg Raises',
    'Russian Twists',
    'Treadmill Running',
    'Elliptical Machine',
    'Stationary Bike',
    'Stair Climber',
  ];

  Set<String> selectedExercises = Set<String>();
  List<Map<String, dynamic>> userPlans = [];

  void _showExerciseSelectionPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                'Select Exercises',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF1C1C1E),
              content: SingleChildScrollView(
                child: Column(
                  children: exercises.map((exercise) {
                    return CheckboxListTile(
                      title: Text(
                        exercise,
                        style: TextStyle(color: Colors.white),
                      ),
                      value: selectedExercises.contains(exercise),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null) {
                            if (value) {
                              selectedExercises.add(exercise);
                            } else {
                              selectedExercises.remove(exercise);
                            }
                          }
                        });
                      },
                      activeColor: Colors.white,
                      checkColor: Colors.white,
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    // Print the selected exercises
                    print(selectedExercises);

                    // Make POST request
                    await createPlan(widget.userId, selectedExercises.toList());

                    setState(() {
                      // Unselect all exercises
                      selectedExercises.clear();
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> createPlan(int userId, List<String> exerciseList) async {
    final Uri uri = Uri.parse('http://localhost:8080/plans/create');

    // Convert the data to JSON format
    final jsonData = jsonEncode({
      'userid': userId.toString(),
      'exerciceList': exerciseList,
    });

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json', // Set the content-type header
      },
      body: jsonData, // Use the JSON data
    );

    if (response.statusCode == 200) {
      fetchUserPlans();
      print('Plan created successfully');
    } else {
      print('Failed to create plan. Status code: ${response.statusCode}');
    }
  }

  Future<void> fetchUserPlans() async {
    final Uri uri = Uri.parse(
        'http://localhost:8080/plans/get-user-plans/${widget.userId}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      setState(() {
        userPlans = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      });
    } else {
      print('Failed to fetch user plans. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserPlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: const Color(0xFF1C1C1E),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: ListView(
              children: userPlans.map((plan) {
                return Card(
                  child: ListTile(
                    title: Text(
                      'Plan #: ${plan['exerciceList'].join(', ')}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showExerciseSelectionPopup(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFA4DC5D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text(
                  'Add Planning',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
