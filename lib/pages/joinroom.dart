
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/availablerooms.dart';
import 'package:flutter_application_1/pages/room.dart';

class joinroom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Join room')),
      body: Padding(
          padding: const EdgeInsets.all(8.0), // Padding around the entire set of buttons
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildButton(context,"Badminton"),
              SizedBox(height: 2.0), // Space between buttons
              buildButton(context,"Football"),

              SizedBox(height: 2.0),
              buildButton(context,"Volleyball"),

              SizedBox(height: 2.0), // Space between buttons
              buildButton(context,"Ball Badminton"),

              SizedBox(height: 2.0),
              buildButton(context,"Handball"),

              SizedBox(height: 2.0),
              buildButton(context,"Cricket"),

              SizedBox(height: 2.0),
              buildButton(context,"Basketball"),
            ],
          ),
        ),
      );
    
  }

  Widget buildButton(BuildContext context, String title) {
    return SizedBox(
      width: double.infinity, // This will cover the entire width
      child: TextButton(
        onPressed: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => availableRooms(title: title),
          ),
        );
        },
        child: Text(title),
        style: TextButton.styleFrom(
           
          foregroundColor: Colors.blue,
         side: BorderSide(color: Colors.blue),
          padding: EdgeInsets.all(12.0),
          // Padding inside the button
        ),
      ),
    );
    
  }
}
