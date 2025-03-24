import 'package:flutter/material.dart';
import 'chatbot.dart';
import 'pharmacy.dart';
import 'consultation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConsultationPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatbotPage(userName: "Vivek")),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color changed to white
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Gradient Header Removed - Now White Background
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 18, 21, 58), // Black
                    Color.fromARGB(255, 15, 49, 107), // Deep Dark Blue
                  ],
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
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/user.jpg'),
                        radius: 30,
                      ),
                      Icon(Icons.notifications, size: 30, color: Colors.black),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ), // Changed to black for contrast
                  ),
                  Text(
                    "Ruchita",
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "How is it going today?",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Light grey for input field
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: "Search doctor, drugs, articles...",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // 🔹 Quick Access Buttons (Chatbot & Pharmacy)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _quickActionCard(Icons.chat_bubble, "Chatbot", 2),
                  _quickActionCard(Icons.local_pharmacy, "Pharmacy", null),
                ],
              ),
            ),
            SizedBox(height: 20),

            // 🔹 Health Articles Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Health Articles",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text("See all", style: TextStyle(color: Colors.blueAccent)),
                ],
              ),
            ),
            SizedBox(height: 10),

            _buildArticleCard(
              "The 25 Healthiest Fruits You Can Eat",
              "assets/fruit.jpeg",
            ),
            _buildArticleCard(
              "The Impact of COVID-19 on Healthcare Systems",
              "assets/covid.png",
            ),

            // 🔹 Additional Options
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _menuOption(Icons.calendar_today, "Book Appointment"),
                  _menuOption(Icons.file_present, "View Health Records"),
                  _menuOption(Icons.alarm, "Medication Reminders"),
                  _menuOption(Icons.support_agent, "Contact Support"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Changed from black to white
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

  // 🔹 Chatbot & Pharmacy Quick Access
  Widget _quickActionCard(IconData icon, String title, int? pageIndex) {
    return GestureDetector(
      onTap: () {
        if (title == "Chatbot") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatbotPage(userName: "Vivek"),
            ),
          );
        } else if (title == "Pharmacy") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PharmacyPage()),
          );
        } else if (pageIndex != null) {
          setState(() {
            _selectedIndex = pageIndex;
          });
        }
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              Icon(icon, size: 24, color: Colors.blueAccent),
              SizedBox(height: 5),
              Text(title, style: TextStyle(fontSize: 12, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Article Cards
  Widget _buildArticleCard(String title, String imagePath) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                imagePath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Menu Options
  Widget _menuOption(IconData icon, String title) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: TextStyle(color: Colors.black)),
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
      ),
    );
  }
}
