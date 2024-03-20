import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(75.0), // Set your desired height here
        child: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0, // Remove shadow
          title: const Padding(
            padding:
                EdgeInsets.only(top: 25.0), // Add your desired padding here
            child: Text("AU SPORTS",
            style: TextStyle(
              color: Colors.white, // Set the text color to blue
              fontSize: 24,
          
            ),),
          ),

          centerTitle: true, // You can set a title here if you want
        ),
      ),
      body: Container(
        width: double.infinity, // Makes the container take up the full width
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 250, 250, 250)),
        child: Center(
          child: Container(
            width: 300,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Use only the space needed by the children
              children: [
                buildButton(context, 'Sports', '/Sports'),
                const SizedBox(height: 30.0),
                buildButton(context, 'Anouncement', '/Anouncement'),
                const SizedBox(height: 30.0),
                buildButton(context, 'Events', '/Events'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String label, String routeName) {
    return SizedBox(
      width: 200.0,
      height: 60.0,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, routeName);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          foregroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 255, 255, 255)),
        ),
        child: Text(label),
      ),
    );
  }
}
