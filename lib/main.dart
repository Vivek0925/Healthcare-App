import 'package:flutter/material.dart';
import 'pages/homepage.dart';

final auroraApiKey = " AIzaSyBDoEgcfE-f0ZBJFWLa8vi68TMenzT2mfg";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Healthcare App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}
