import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'homepage.dart';

class PharmacyPage extends StatelessWidget {
  const PharmacyPage({super.key});

  // 🔹 Function to Open Netmeds URL
  void _openNetmeds() async {
    final Uri url = Uri.parse('https://www.netmeds.com/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pharmacy", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Available Medicines",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 15),

            // 🔹 Medicine List with Stylish Cards
            Expanded(
              child: ListView(
                children: [
                  _buildMedicineCard(
                    "Paracetamol",
                    "Used to treat fever and mild pain.",
                    "assets/paracetamol.jpg",
                  ),
                  _buildMedicineCard(
                    "Ibuprofen",
                    "Pain reliever and anti-inflammatory.",
                    "assets/ibuprofen.jpg",
                  ),
                  _buildMedicineCard(
                    "Vitamin C",
                    "Boosts immunity and improves skin health.",
                    "assets/vitamin_c.jpg",
                  ),
                  _buildMedicineCard(
                    "Order from Netmeds",
                    "Click here to order medicine online.",
                    "assets/netmeds_logo.png",
                    isNetmeds: true, // Special button-like card for Netmeds
                    onTap: _openNetmeds,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // 🔹 Modern Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Consult',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chatbot'),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pharmacy),
            label: 'Pharmacy',
          ),
        ],
        currentIndex: 3, // Since we're on the Pharmacy page
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
      ),
    );
  }

  // 🔹 Medicine Card Widget with Enhanced Design
  Widget _buildMedicineCard(
    String name,
    String description,
    String imagePath, {
    bool isNetmeds = false,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(vertical: 10),
        color: isNetmeds ? Colors.blueAccent : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.broken_image,
                      size: 70,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: isNetmeds ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: isNetmeds ? Colors.white70 : Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
              if (isNetmeds)
                Icon(
                  Icons.open_in_new,
                  color: Colors.white,
                ), // Netmeds button icon
              if (!isNetmeds)
                Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
