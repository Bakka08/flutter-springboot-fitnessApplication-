import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  final int userId;
  Chat({required this.userId});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Map<String, dynamic>> messages = [];
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    final response = await http
        .get(Uri.parse('http://localhost:8080/chats/user/${widget.userId}'));

    if (response.statusCode == 200) {
      setState(() {
        messages = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      });
    } else {
      // Handle error
      print('Failed to load messages');
    }
  }

  Future<void> sendMessage() async {
    final message = messageController.text.trim();

    if (message.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://localhost:8080/chats/create/user'),
        body: jsonEncode({
          "sender": widget.userId,
          "receiver": 1,
          "data": message,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {
        // Message sent successfully, fetch updated messages
        fetchMessages();
        // Clear the input field
        messageController.clear();
      } else if (response.statusCode == 400) {
        // Invalid sender or receiver, show an error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Invalid sender or receiver.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Handle other errors
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send message. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // Show an alert for empty message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter a message before sending.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Container(
              color: Color(0xFF1C1C1E),
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                children: messages.map((message) {
                  final isSentByMe = message['sender'] == widget.userId;
                  return buildMessage(message['data'], isSentByMe: isSentByMe);
                }).toList(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Color(0xFF1C1C1E),
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  IconButton(
                    icon: Icon(Icons.send),
                    color: Colors.white,
                    iconSize: 22.0,
                    onPressed: () {
                      // Call the function to send the message
                      sendMessage();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessage(String text, {required bool isSentByMe}) {
    return Align(
      alignment: isSentByMe ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.white : Color(0xFFA4DC5D),
          borderRadius: isSentByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSentByMe ? Colors.black : Colors.black,
          ),
        ),
      ),
    );
  }
}
