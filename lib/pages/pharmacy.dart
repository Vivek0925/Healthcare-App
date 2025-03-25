import 'package:flutter/material.dart';
import 'homepage.dart';
import 'chatbot.dart';
import 'consultation.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({super.key});

  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> medicines = [
    {
      "name": "Paracetamol",
      "category": "Pain Relief",
      "color": Colors.blue.shade100,
      "expanded": false,
      "description": "Used to treat fever and mild pain.",
    },
    {
      "name": "Amoxicillin",
      "category": "Antibiotics",
      "color": Colors.green.shade100,
      "expanded": false,
      "description": "Used to treat bacterial infections.",
    },
    {
      "name": "Omeprazole",
      "category": "Digestive",
      "color": Colors.orange.shade100,
      "expanded": false,
      "description": "Reduces stomach acid and prevents ulcers.",
    },
    {
      "name": "Metformin",
      "category": "Diabetes",
      "color": Colors.pink.shade100,
      "expanded": false,
      "description": "Helps control blood sugar levels.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Pharmacy",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "🔍 Search for medicines...",
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 15),

            Text(
              "Common Medicines",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // 🔹 Medicine List (Expandable)
            Expanded(
              child: ListView.builder(
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  var medicine = medicines[index];
                  bool matchesSearch =
                      _searchController.text.isEmpty ||
                      medicine["name"].toLowerCase().contains(
                        _searchController.text.toLowerCase(),
                      );

                  if (!matchesSearch) return SizedBox.shrink();

                  return _buildMedicineCard(medicine, index);
                },
              ),
            ),
          ],
        ),
      ),

      // 🔹 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // ✅ "Pharmacy" Active
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ConsultationPage()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatbotPage(userName: "User"),
              ),
            );
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chatbot'),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pharmacy),
            label: 'Pharmacy',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Articles'),
        ],
      ),
    );
  }

  // 🔹 Medicine Card Widget
  Widget _buildMedicineCard(Map<String, dynamic> medicine, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ExpansionTile(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: medicine["color"],
              child: Icon(Icons.medical_services, color: Colors.white),
            ),
            SizedBox(width: 10),
            Text(
              medicine["name"],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: medicine["color"],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              medicine["category"],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              medicine["description"],
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
