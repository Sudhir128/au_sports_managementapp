import 'package:flutter/material.dart';

class aListScreen extends StatelessWidget {
  final List<announcement> events = [
    announcement(
      title: 'SAAS',
      description: 'Student association member',
      imageAssetPath: 'lib/announcements/announcement2.jpg',
    ),
    announcement(
      title: 'Time table',
      description: 'Regular/arrear exam',
      imageAssetPath: 'lib/announcements/announcement1.jpg',
    ),
    announcement(
      title: 'Student Arts society',
      description: 'Student Arts society members',
      imageAssetPath: 'lib/announcements/announcement3.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcement List'),
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
          return EventCard(an: events[index]);
        },
      ),
    );
  }
}

class announcement {
  final String title;
  final String description;
  final String imageAssetPath;

  announcement({
    required this.title,
    required this.description,
    required this.imageAssetPath,
  });
}

class EventCard extends StatelessWidget {
  final announcement an;

  EventCard({required this.an});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 40,
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            an.imageAssetPath,
            fit: BoxFit.cover,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  an.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  an.description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the view image screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ViewImageScreen(imagePath: an.imageAssetPath),
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
        title: Text('View Announcement'),
      ),
      body: Center(
        child: Image.asset(imagePath),
      ),
    );
  }
}
