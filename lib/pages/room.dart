import 'package:flutter/material.dart';

class room extends StatelessWidget {
  const room({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sports')),
      body: Container(
        width: double.infinity, // Makes the container take up the full width
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: Center(
          child: Container(
            width: 300,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Use only the space needed by the children
              children: [
                buildButton(context, 'Create Room', '/Create Room'),
                const SizedBox(height: 30.0),
                buildButton(context, 'Join Room', '/Join Room'),
                 const SizedBox(height: 30.0),
                buildButton(context, 'My rooms', '/My Room'),
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
