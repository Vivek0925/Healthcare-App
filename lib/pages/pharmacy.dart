import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/medicine.dart';
import 'homepage.dart';
import 'chatbot.dart';
import 'consultation.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({super.key});

  @override
  PharmacyPageState createState() => PharmacyPageState();
}

class PharmacyPageState extends State<PharmacyPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Medicine> medicines = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMedicines();
  }

  void loadMedicines() {
    setState(() {
      medicines = Medicine.getCommonIndianMedicines();
      isLoading = false;
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  // Helper method to get appropriate icon for medicine type
  IconData _getMedicineTypeIcon(String medicineType) {
    switch (medicineType.toLowerCase()) {
      case 'tablet':
        return Icons.medication_rounded;
      case 'syrup':
        return Icons.local_drink_rounded;
      case 'capsule':
        return Icons.egg_alt_rounded;
      case 'injection':
        return Icons.vaccines;
      case 'spray':
        return Icons.cleaning_services_rounded;
      case 'solution':
        return Icons.opacity_rounded;
      case 'gel':
        return Icons.water_drop_rounded;
      case 'cream':
        return Icons.spa_rounded;
      case 'powder':
        return Icons.grain_rounded;
      default:
        return Icons.medication_liquid_rounded;
    }
  }

  // Helper method to get color for medicine type icon
  Color _getMedicineTypeColor(String medicineType) {
    switch (medicineType.toLowerCase()) {
      case 'tablet':
        return Colors.blue;
      case 'syrup':
        return Colors.purple;
      case 'capsule':
        return Colors.orange;
      case 'injection':
        return Colors.red;
      case 'spray':
        return Colors.teal;
      case 'solution':
        return Colors.cyan;
      case 'gel':
        return Colors.indigo;
      case 'cream':
        return Colors.pink;
      case 'powder':
        return Colors.amber;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Pharmacy",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: "🔍 Search for medicines...",
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Available Medicines",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: medicines.length,
                      itemBuilder: (context, index) {
                        var medicine = medicines[index];
                        bool matchesSearch = _searchController.text.isEmpty ||
                            medicine.name
                                .toLowerCase()
                                .contains(_searchController.text.toLowerCase());

                        if (!matchesSearch) return const SizedBox.shrink();

                        final Color iconColor =
                            _getMedicineTypeColor(medicine.medicineType);
                        final IconData iconData =
                            _getMedicineTypeIcon(medicine.medicineType);

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Medicine Type Icon
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: iconColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        iconData,
                                        size: 48,
                                        color: iconColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  // Medicine details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                medicine.name,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '₹${medicine.price.toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'By ${medicine.manufacturer}',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Chip(
                                              label: Text(medicine.category),
                                              backgroundColor: Colors.blue[100],
                                              labelPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              padding: const EdgeInsets.all(0),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            const SizedBox(width: 8),
                                            Chip(
                                              label: Text(
                                                medicine.medicineType
                                                    .toUpperCase(),
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                              backgroundColor:
                                                  iconColor.withOpacity(0.2),
                                              labelPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              padding: const EdgeInsets.all(0),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          medicine.description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: OutlinedButton.icon(
                                                icon: const Icon(Icons.shopping_cart),
                                                label: const Text('Add to Cart'),
                                                style: OutlinedButton.styleFrom(
                                                  foregroundColor: Colors.blue,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: ElevatedButton.icon(
                                                icon: const Icon(Icons
                                                    .shopping_bag_outlined),
                                                label: const Text('Buy Now'),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                ),
                                                onPressed: () =>
                                                    _launchURL(medicine.buyUrl),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ConsultationPage()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatbotPage(userName: "User"),
              ),
            );
          }
        },
        items: const [
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
}
