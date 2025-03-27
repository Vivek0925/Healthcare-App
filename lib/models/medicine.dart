class Medicine {
  final String name;
  final String category;
  final String description;
  final String imageUrl; // Keeping this for backward compatibility
  final double price;
  final String manufacturer;
  final String buyUrl;
  final String medicineType; // New field for medicine type (tablet, syrup, etc)

  Medicine({
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.manufacturer,
    required this.buyUrl,
    required this.medicineType,
  });

  factory Medicine.fromOpenFDA(Map<String, dynamic> json) {
    return Medicine(
      name: json['openfda']?['brand_name']?[0] ?? 'Unknown',
      manufacturer: json['openfda']?['manufacturer_name']?[0] ?? 'Unknown',
      category: json['openfda']?['route']?[0] ?? 'General',
      description:
          json['indications_and_usage']?[0] ?? 'No description available',
      // Using a placeholder image since OpenFDA doesn't provide images
      imageUrl:
          'https://via.placeholder.com/150?text=${json['openfda']?['brand_name']?[0] ?? 'Medicine'}',
      price: 29.99, // Hardcoded price as per requirement
      buyUrl:
          'https://www.netmeds.com/search?q=${json['openfda']?['brand_name']?[0] ?? ''}',
      medicineType: 'Unknown', // Placeholder value
    );
  }

  static List<Medicine> getCommonIndianMedicines() {
    return [
      Medicine(
        name: 'Paracetamol',
        manufacturer: 'Cipla',
        category: 'Pain Relief',
        description:
            'Common pain reliever and fever reducer. Used for headache, body ache and fever.',
        imageUrl: 'assets/Paracetamol.jpg',
        price: 35.50, // Price in INR
        buyUrl: 'https://www.netmeds.com/search?q=paracetamol',
        medicineType: 'tablet',
      ),
      Medicine(
        name: 'Combiflam',
        manufacturer: 'Sanofi India',
        category: 'Pain Relief',
        description:
            'Combination of Ibuprofen and Paracetamol for strong pain relief.',
        imageUrl:
            'https://www.netmeds.com/images/product-v1/600x600/341517/combiflam_tablet_20_s_0.jpg',
        price: 41.24,
        buyUrl: 'https://www.netmeds.com/search?q=combiflam',
        medicineType: 'tablet',
      ),
      Medicine(
        name: 'Zincovit',
        manufacturer: 'Apex Laboratories',
        category: 'Supplements',
        description: 'Multivitamin and multimineral supplement for immunity.',
        imageUrl:
            'https://www.netmeds.com/images/product-v1/600x600/341652/zincovit_tablet_15_s_0.jpg',
        price: 105.60,
        buyUrl: 'https://www.netmeds.com/search?q=zincovit',
        medicineType: 'tablet',
      ),
      Medicine(
        name: 'Allegra 120mg',
        manufacturer: 'Sanofi India',
        category: 'Allergy',
        description: 'Antihistamine used to treat allergies and cold symptoms.',
        imageUrl:
            'https://www.netmeds.com/images/product-v1/600x600/323667/allegra_120mg_tablet_10_s_0.jpg',
        price: 175.25,
        buyUrl: 'https://www.netmeds.com/search?q=allegra',
        medicineType: 'tablet',
      ),
      Medicine(
        name: 'Crocin Syrup',
        manufacturer: 'GSK',
        category: 'Pain Relief',
        description:
            'Fast acting liquid paracetamol for children, relieves pain and fever.',
        imageUrl:
            'https://www.netmeds.com/images/product-v1/600x600/412860/crocin_advance_tablet_20_s_0.jpg',
        price: 48.90,
        buyUrl: 'https://www.netmeds.com/search?q=crocin+syrup',
        medicineType: 'syrup',
      ),
      Medicine(
        name: 'Dolo 650',
        manufacturer: 'Micro Labs Ltd',
        category: 'Pain Relief',
        description: 'Paracetamol tablet for fever and mild to moderate pain.',
        imageUrl:
            'https://www.netmeds.com/images/product-v1/600x600/811460/dolo_650mg_tablet_15_s_0.jpg',
        price: 29.90,
        buyUrl: 'https://www.netmeds.com/search?q=dolo+650',
        medicineType: 'tablet',
      ),
      Medicine(
        name: 'Cremaffin Plus',
        manufacturer: 'Abbott',
        category: 'Digestive',
        description: 'Liquid laxative for constipation relief.',
        imageUrl:
            'https://www.netmeds.com/images/product-v1/600x600/313786/pan_d_capsule_15_s_0.jpg',
        price: 138.50,
        buyUrl: 'https://www.netmeds.com/search?q=cremaffin',
        medicineType: 'syrup',
      ),
      Medicine(
        name: 'Azithral 500',
        manufacturer: 'Alembic Pharmaceuticals',
        category: 'Antibiotic',
        description: 'Antibiotic used to treat bacterial infections.',
        imageUrl:
            'https://www.netmeds.com/images/product-v1/600x600/341436/azithral_500mg_tablet_5_s_0.jpg',
        price: 85.30,
        buyUrl: 'https://www.netmeds.com/search?q=azithral',
        medicineType: 'tablet',
      ),
      Medicine(
        name: 'Benadryl Cough Syrup',
        manufacturer: 'Johnson & Johnson',
        category: 'Cough & Cold',
        description: 'Relieves cough and cold symptoms.',
        imageUrl: '',
        price: 116.75,
        buyUrl: 'https://www.netmeds.com/search?q=benadryl',
        medicineType: 'syrup',
      ),
      Medicine(
        name: 'Digene',
        manufacturer: 'Abbott',
        category: 'Digestive',
        description: 'Antacid gel for relief from acidity and gas.',
        imageUrl: '',
        price: 145.20,
        buyUrl: 'https://www.netmeds.com/search?q=digene',
        medicineType: 'gel',
      ),
      Medicine(
        name: 'Volini Spray',
        manufacturer: 'Sun Pharma',
        category: 'Pain Relief',
        description:
            'Topical spray for quick pain relief in muscles and joints.',
        imageUrl: '',
        price: 235.00,
        buyUrl: 'https://www.netmeds.com/search?q=volini+spray',
        medicineType: 'spray',
      ),
      Medicine(
        name: 'Betadine',
        manufacturer: 'Win Medicare',
        category: 'Antiseptic',
        description:
            'Antiseptic solution for wound cleaning and infection prevention.',
        imageUrl: '',
        price: 88.50,
        buyUrl: 'https://www.netmeds.com/search?q=betadine',
        medicineType: 'solution',
      ),
    ];
  }
}
