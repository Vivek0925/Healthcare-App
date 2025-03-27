import 'package:flutter/material.dart';

class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  int _selectedIndex = 3; // Default selected index for "Articles"

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

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      // Navigate to the correct page only if it's not the current page
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/consult');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/chatbot');
          break;
        case 3:
          // Already on Articles page, do nothing
          break;
      }
    }
  }

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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Consult',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chatbot'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Articles'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _onItemTapped(index);
        },
      ),
    );
  }
}
