import 'package:flutter/material.dart';

class ArticlesPage extends StatelessWidget {
  final List<Map<String, String>> articles = [
    {
      "title": "The Importance of Regular Health Checkups",
      "description":
          "Learn why preventive care through regular health screenings is essential.",
    },
    {
      "title": "Healthy Eating Habits",
      "description":
          "Discover the benefits of a balanced diet for long-term health.",
    },
    {
      "title": "Effective Home Workouts",
      "description":
          "Stay fit with simple exercises you can do at home without equipment.",
    },
    {
      "title": "Managing Stress for Better Health",
      "description":
          "Explore techniques to reduce stress and improve mental well-being.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Articles"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                articles[index]["title"]!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                articles[index]["description"]!,
                style: TextStyle(fontSize: 14),
              ),
              leading: Icon(Icons.article, color: Colors.blueAccent),
            ),
          );
        },
      ),
    );
  }
}
