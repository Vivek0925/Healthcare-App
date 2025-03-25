import 'package:flutter/material.dart';
import 'chatbot.dart';
import 'consultation.dart';
import 'articles.dart';
import 'pharmacy.dart'; // Ensure this exists

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // 🔹 Article Card Widget
  Widget _buildArticleCard(String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _onItemTapped(int index) {
    if (index == 1) {
      // Navigate to Consultation Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConsultationPage()),
      );
    } else if (index == 2) {
      // Navigate to Chatbot Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatbotPage(userName: "User")),
      );
    } else if (index == 3) {
      // Navigate to Articles Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ArticlesPage()),
      );
    } else {
      // Stay on Home Page
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Gradient Header
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade600, Colors.blue.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Good Evening,",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.blueAccent),
                      ),
                    ],
                  ),
                  Text(
                    "User",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search for symptoms, medicines...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.mic, color: Colors.blueAccent),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // 🔹 Services Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Services",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _serviceCard(
                    Icons.chat,
                    "AI Chatbot",
                    ChatbotPage(userName: "User"),
                  ),
                  _serviceCard(
                    Icons.local_pharmacy,
                    "Pharmacy",
                    PharmacyPage(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _serviceCard(
                    Icons.local_hospital,
                    "Find Doctor",
                    ConsultationPage(),
                  ),
                  _serviceCard(Icons.article, "Articles", ArticlesPage()),
                ],
              ),
            ),
            SizedBox(height: 20),

            // 🔹 Daily Health Tips
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Daily Health Tips",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("See All", style: TextStyle(color: Colors.blueAccent)),
                ],
              ),
            ),
            SizedBox(height: 10),
            _healthTipCard(),

            // 🔹 Latest Articles (Scrollable Section)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Articles",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("See All", style: TextStyle(color: Colors.blueAccent)),
                ],
              ),
            ),
            _buildArticleCard(
              "The Importance of Regular Health Check-ups",
              "Learn why preventive care through health screenings is essential.",
            ),
            _buildArticleCard(
              "How to Boost Your Immune System Naturally",
              "Simple habits to improve immunity and stay healthy.",
            ),
            _buildArticleCard(
              "Managing Stress for a Healthier Life",
              "Techniques to reduce stress and improve mental well-being.",
            ),
          ],
        ),
      ),

      // 🔹 Bottom Navigation Bar
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
        onTap: _onItemTapped,
      ),
    );
  }

  // 🔹 Services Card
  Widget _serviceCard(IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            children: [
              Icon(icon, size: 30, color: Colors.blueAccent),
              SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 14, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Health Tips Card
  Widget _healthTipCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: Colors.blue.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("💧 Hydration", style: TextStyle(color: Colors.white)),
              SizedBox(height: 5),
              Text(
                "Stay Hydrated",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Drink at least 8 glasses of water daily to maintain good health and energy levels.",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
