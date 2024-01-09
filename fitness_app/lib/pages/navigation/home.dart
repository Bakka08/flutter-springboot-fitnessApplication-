import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../signup/gender.dart';

class Home extends StatefulWidget {
  final int userId; // Add userId field to accept user id

  // Sample data for the cards with example image URLs
  final List<Map<String, String>> tipsData = [
    {
      'imageUrl':
          'https://static01.nyt.com/images/2013/06/19/health/19physed_well/19physed_well-tmagArticle.jpg',
      'title': 'Cardio Exercise',
      'description':
          'Engage in at least 30 minutes of cardio exercise most days of the week for a healthy heart.',
    },
    {
      'imageUrl': 'https://image.boxrox.com/2022/07/Heavy-Back-squat.jpg',
      'title': 'Strength Training',
      'description':
          'Incorporate strength training exercises to build muscle and improve overall body strength.',
    },
    {
      'imageUrl':
          'https://sleepcenterinfo.com/wp-content/uploads/2022/05/A-young-man-sleeping-in-the-starfish-position-in-bed-1280x720.jpg',
      'title': 'Adequate Sleep',
      'description':
          'Ensure you get 7-9 hours of quality sleep each night for optimal physical and mental health.',
    },
    {
      'imageUrl':
          'https://bcdairy.ca/wp-content/uploads/2021/08/Variety_Image_747px.jpg',
      'title': 'Healthy Eating',
      'description':
          'Include a variety of fruits, vegetables, and whole grains in your diet for balanced nutrition.',
    },
  ];

  Home({required this.userId}); // Update constructor to accept userId

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int calorie = 0;
  int protein = 0;
  int fat = 0;
  int carbs = 0;
  String userName = ''; // Added to store user's full name

  Future<void> _fetchUserMacros() async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/users/get-macro/${widget.userId}'),
    );

    if (response.statusCode == 200) {
      final data = response.body;
      final parsedData = json.decode(data);

      setState(() {
        calorie = parsedData['data']['calorie'].toInt();
        protein = parsedData['data']['balanced']['protein'].toInt();
        fat = parsedData['data']['balanced']['fat'].toInt();
        carbs = parsedData['data']['balanced']['carbs'].toInt();
      });
    } else {
      print('Error fetching user macros: ${response.statusCode}');
      // Handle error appropriately based on your application requirements
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Gender(userId: widget.userId),
        ),
      );
    }
  }

  Future<void> _fetchUserName() async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/users/get-full-name/${widget.userId}'),
    );

    if (response.statusCode == 200) {
      final data = response.body;
      setState(() {
        userName = data;
      });
    } else {
      print('Error fetching user name: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserMacros();
    _fetchUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        color: Color(0xFF1C1C1E),
        child: Column(
          children: [
            // First row with flex 0.1
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: 'Hello ',
                        ),
                        TextSpan(
                          text: userName.isEmpty ? 'User' : userName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Second row with flex 4.5 (two sub-rows)
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  // Upper sub-row with flex 3
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Center(
                                child: MouseRegion(
                                  onEnter: (event) {},
                                  onExit: (event) {},
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      elevation: 0,
                                    ),
                                    child: Container(
                                      width: 180,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(
                                              0xFFA4DC5D), // Change color here
                                          width: 8.0,
                                        ),
                                        color: Colors.transparent,
                                      ),
                                      child: Center(
                                        child: RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '$calorie ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24,
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'calories',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Lower sub-row with flex 2
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Center(
                                child: MouseRegion(
                                  onEnter: (event) {},
                                  onExit: (event) {},
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      elevation: 0,
                                    ),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 4.0,
                                        ),
                                        color: Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '$protein',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              'Protein',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    199, 255, 255, 255),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Center(
                                child: MouseRegion(
                                  onEnter: (event) {},
                                  onExit: (event) {},
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      elevation: 0,
                                    ),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 4.0,
                                        ),
                                        color: Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '$carbs',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              'Carbs',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Center(
                                child: MouseRegion(
                                  onEnter: (event) {},
                                  onExit: (event) {},
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      elevation: 0,
                                    ),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 4.0,
                                        ),
                                        color: Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '$fat',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              'Fat',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
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
            // Third row with flex 4.5
            Expanded(
              flex: 9,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(
                    children: widget.tipsData.map((tip) {
                      return FractionallySizedBox(
                        widthFactor:
                            0.9, // Adjust this value to control the card width
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                ),
                                child: Image.network(
                                  tip['imageUrl']!,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tip['title']!,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      tip['description']!,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
