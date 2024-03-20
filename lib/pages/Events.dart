import 'package:flutter/material.dart';

class EventListScreen extends StatelessWidget {
  final List<Event> events = [
    Event(
      title: 'U S University Alumini fair',
      description: 'venue : american center chennai',
      date: 'November 18',
      imageAssetPath: 'lib/events/event2.jpg',
    ),
    Event(
      title: 'CTF projects',
      description: 'long tearm and short tearm projects',
      date: '2023-11-27',
      imageAssetPath: 'lib/events/event3.jpg',
    ),
    Event(
      title: 'VYUHAA 23',
      description: 'events and karnivals',
      date: 'october 14',
      imageAssetPath: 'lib/events/event1.jpg',
    ),
    Event(
      title: 'VYUHAA 23',
      description: 'x hall EEE department',
      date: 'october 14',
      imageAssetPath: 'lib/events/event5.jpg',
    ),
    Event(
      title: 'ALUMINI MEET 23',
      description: 'Ramanujam hall',
      date: 'october 15',
      imageAssetPath: 'lib/events/event4.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event List'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 50.2,
        toolbarOpacity: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 50,
        backgroundColor: Colors.blueGrey[400],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventCard(event: events[index]);
        },
      ),
    );
  }
}

class Event {
  final String title;
  final String description;
  final String date;
  final String imageAssetPath;

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.imageAssetPath,
  });
}

class EventCard extends StatelessWidget {
  final Event event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 40,
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            event.imageAssetPath,
            fit: BoxFit.cover,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Date: ${event.date}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  event.description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the view image screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ViewImageScreen(imagePath: event.imageAssetPath),
                      ),
                    );
                  },
                  child: Text('View Image'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ViewImageScreen extends StatelessWidget {
  final String imagePath;

  ViewImageScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Image'),
      ),
      body: Center(
        child: Image.asset(imagePath),
      ),
    );
  }
}
