import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'homepage.dart';
import 'consultation.dart';
import 'articles.dart';

class ChatbotPage extends StatefulWidget {
  final String userName;
  const ChatbotPage({super.key, required this.userName});

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  File? selectedImageFile;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({"sender": "user", "text": _controller.text});
        messages.add({"sender": "bot", "text": "I'm still learning! 😊"});
        _controller.clear();
      });
    } else if (selectedImageFile != null) {
      setState(() {
        messages.add({"sender": "user", "image": selectedImageFile});
        selectedImageFile = null;
      });
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedImageFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Healthcare Assistant",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.blueAccent),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blueAccent,
          tabs: [Tab(text: "Chat"), Tab(text: "History")],
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _chatScreen(), // Chat screen
                _historyScreen(), // History screen
              ],
            ),
          ),
          _inputBar(), // Chat input bar
        ],
      ),

      // 🔹 Updated Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // ✅ "Chatbot" is Active
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
              MaterialPageRoute(builder: (context) => ArticlesPage()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Consultation',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chatbot'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Articles'),
        ],
      ),
    );
  }

  // 🔹 Chat Screen UI
  Widget _chatScreen() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              var message = messages[index];
              bool isUser = message["sender"] == "user";

              return Align(
                alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blueAccent : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      message.containsKey("image")
                          ? Image.file(
                            message["image"],
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                          : Text(
                            message["text"] ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              color: isUser ? Colors.white : Colors.black87,
                            ),
                          ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // 🔹 History Screen UI
  Widget _historyScreen() {
    return Center(
      child: Text(
        "No chat history available",
        style: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }

  // 🔹 Chat Input Bar UI
  Widget _inputBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.attach_file, color: Colors.blue),
              onPressed: _pickFile,
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText:
                      selectedImageFile != null
                          ? "📂 Image selected"
                          : "Type a message...",
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: Colors.blue),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
