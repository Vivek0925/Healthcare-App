# Healthcare App

Welcome to the Healthcare App! This application is designed to provide users with a comprehensive healthcare experience, focusing on improving access to healthcare services in underserved communities. This project was created as part of the GDG On Campus Solution Challenge to address critical healthcare accessibility issues.

## Project Background

### Problem Statement

Many communities, especially in rural and remote areas, face significant challenges in accessing basic healthcare services. This results in:

- Poor health outcomes
- Preventable diseases
- Reduced quality of life
- Limited access to medical professionals
- Inadequate healthcare infrastructure
- Lack of awareness about preventive care

### Our Solution

This Healthcare App aims to bridge the healthcare accessibility gap by providing a comprehensive digital platform that aligns with UN SDG 3: Good Health and Well-being. Our solution focuses on delivering accessible, affordable, and quality healthcare services to underserved communities through:

- Virtual doctor consultations
- AI-powered health assistance
- Health education through articles
- Easy access to pharmacy services
- Preventive care information

---

## Features

### 1. **Home Page**

- A user-friendly dashboard with quick access to all services.
- Daily health tips to promote a healthier lifestyle.
- Latest health articles displayed in a scrollable section.

### 2. **AI Chatbot**

- Aurora-Z2, a highly skilled healthcare AI assistant.
- Provides professional, evidence-based, and empathetic responses.
- Includes medical disclaimers and encourages seeking professional help when necessary.
- Supports text-based queries and image uploads (currently limited to text-based responses).

### 3. **Doctor Consultation**

- Book appointments with professional doctors.
- Get expert medical advice tailored to your needs.

### 4. **Health Articles**

- Access the latest health-related articles.
- Articles include titles, descriptions, authors, and publication dates.
- Detailed article view with full content and images.

### 5. **Pharmacy Services**

- Explore and purchase medicines conveniently.

---

## Tech Stack

### **Frontend**

- **Flutter**: Cross-platform framework for building the app.
- **Dart**: Programming language for Flutter development.

### **Backend**

- **NewsAPI**: Fetches health-related articles.
- **Custom API Integration**: For chatbot and other services.

### **Libraries & Tools**

- `http`: For making API requests.
- `intl`: For date formatting.
- `file_picker`: For selecting and uploading files.

---

## Folder Structure

```
Healthcare-App/
├── android/          # Android-specific files
├── assets/           # Images and other assets
├── build/            # Build files
├── ios/              # iOS-specific files
├── lib/              # Main application code
│   ├── models/       # Data models
│   ├── pages/        # UI pages
│   ├── services/     # API and service integrations
├── linux/            # Linux-specific files
├── macos/            # macOS-specific files
├── test/             # Test files
├── web/              # Web-specific files
├── windows/          # Windows-specific files
├── pubspec.yaml      # Flutter dependencies
└── README.md         # Project documentation
```

---

## How to Run the App

1. Clone the repository:

   ```bash
   git clone <repository-url>
   ```

2. Navigate to the project directory:

   ```bash
   cd Healthcare-App
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

---

## GDG On Campus Solution Challenge

This project is our submission to the GDG On Campus Solution Challenge, where we aim to create innovative solutions for real-world problems. Our focus aligns with UN SDG 3 (Good Health and Well-being), and we've utilized various Google technologies to build a scalable and sustainable solution.
