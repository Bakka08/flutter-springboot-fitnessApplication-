import 'package:flutter/material.dart';
import 'login.dart';
import 'signup/signup.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      body: Column(
        children: [
          // First Row (flex 8) - Contains the image
          Expanded(
            flex: 8,
            child: Center(
              child: Container(
                width: 200, // Set your desired width
                height: 200, // Set your desired height
                child: Image.asset('images/LoadingLogo.png'),
              ),
            ),
          ),
          // Second Row (flex 2) - Contains two buttons in a column
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Login screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(400, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    backgroundColor: Color(0xFF1C1C1E),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the SignUp screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(400, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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
