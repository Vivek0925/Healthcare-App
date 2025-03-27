import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'homepage.dart';
import 'consultation.dart';
import 'articles.dart';
import '../main.dart';

class ChatbotPage extends StatefulWidget {
  final String userName;
  const ChatbotPage({super.key, required this.userName});

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> messages = [];
  File? selectedImageFile;
  late TabController _tabController;
  bool _isLoading = false;

  final String _systemPrompt =
      """You are Aurora-Z2, a highly skilled healthcare AI assistant with expertise in medical knowledge and patient care. Your responses should be:
1. Professional and evidence-based
2. Clear and easy to understand
3. Empathetic and patient-focused
4. Always include appropriate medical disclaimers
5. Encourage seeking professional medical help when necessary

Remember to maintain patient confidentiality and avoid making definitive diagnoses.""";

  Future<String> _generateGeminiResponse(String userPrompt) async {
    final String apiUrl =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-pro-exp-03-25:generateContent';

    try {
      final Map<String, dynamic> requestBody = {
        'contents': [
          {
            'role': 'user',
            'parts': [
              {'text': _systemPrompt},
              {'text': userPrompt},
            ],
          },
        ],
        'generationConfig': {
          'temperature': 0.7,
          'topK': 40,
          'topP': 0.95,
          'maxOutputTokens': 1024,
        },
        'safetySettings': [
          {
            'category': 'HARM_CATEGORY_HARASSMENT',
            'threshold': 'BLOCK_MEDIUM_AND_ABOVE',
          },
          {
            'category': 'HARM_CATEGORY_HATE_SPEECH',
            'threshold': 'BLOCK_MEDIUM_AND_ABOVE',
          },
          {
            'category': 'HARM_CATEGORY_SEXUALLY_EXPLICIT',
            'threshold': 'BLOCK_MEDIUM_AND_ABOVE',
          },
          {
            'category': 'HARM_CATEGORY_DANGEROUS_CONTENT',
            'threshold': 'BLOCK_MEDIUM_AND_ABOVE',
          },
        ],
      };

      final response = await http.post(
        Uri.parse('$apiUrl?key=$auroraApiKey'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        debugPrint(data.toString());
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        throw Exception('Failed to generate response: ${response.statusCode}');
      }
    } catch (e) {
      return 'I apologize, but I encountered an error. Please try again later. Error: $e';
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Add initial greeting
    messages.add({
      "sender": "bot",
      "text":
          "Hello! I'm Aurora-Z2, your healthcare assistant. How can I help you today?",
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    String userMessage = _controller.text;
    if (userMessage.isNotEmpty) {
      setState(() {
        messages.add({"sender": "user", "text": userMessage});
        _isLoading = true;
      });
      _controller.clear();

      // Scroll to bottom after adding user message
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

      // Get response from Gemini
      final response = await _generateGeminiResponse(userMessage);

      setState(() {
        messages.add({"sender": "bot", "text": response});
        _isLoading = false;
      });

      // Scroll to bottom after adding bot response
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } else if (selectedImageFile != null) {
      setState(() {
        messages.add({"sender": "user", "image": selectedImageFile});
        messages.add({
          "sender": "bot",
          "text":
              "I apologize, but I'm currently not able to analyze images. Please describe your concern in text.",
        });
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
            controller: _scrollController,
            itemCount: messages.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (_isLoading && index == messages.length) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blueAccent,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Thinking...",
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              }

              var message = messages[index];
              bool isUser = message["sender"] == "user";

              return Align(
                alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
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
