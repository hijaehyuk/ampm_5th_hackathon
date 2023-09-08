import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatMenuRecommendation extends StatefulWidget {
  @override
  _ChatMenuRecommendationState createState() => _ChatMenuRecommendationState();
}

class _ChatMenuRecommendationState extends State<ChatMenuRecommendation> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _chatMessages = [];

  Future<String> generateText(String prompt) async {
    final apiKey = 'api_keykeykeykeykey';
    final endpoint = 'https://api.openai.com/v1/engines/davinci/completions';

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'prompt': prompt,
        'max_tokens': 50, // 원하는 길이로 조정
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final generatedText = data['choices'][0]['text'];
      return generatedText;
    } else {
      throw Exception('Failed to generate text');
    }
  }

  void _sendMessage() async {
    final userMessage = _messageController.text;
    _messageController.clear();
    setState(() {
      _chatMessages.add('사용자: $userMessage');
    });

    final gptResponse = await generateText(userMessage);
    setState(() {
      _chatMessages.add('GPT: $gptResponse');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메뉴 추천 채팅'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_chatMessages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: '메시지 입력',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ChatMenuRecommendation(),
  ));
}
