import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../screens/basket.dart';
import 'package:get/get.dart';

final messages = [
  {"role": "system", "content": "너는 맥도날드 알바생이야."},
  {"role": "system", "content": "앞으로 손님들의 주문을 받을건데"},
  {"role": "system", "content": "손님이 우리가 가지고 있는 메뉴를 주문하면 너가 그걸 장바구니에 넣어주면 되는거야."},
  {"role": "system", "content": "어르신에게 설명해야 하니까 간단하게 한문장으로 출력해줘"},
  {"role": "system", "content": "메뉴 추천은 리스트로 메뉴만 나오도록 출력해줘"}
];

class ChatMenuRecommendation extends StatefulWidget {
  @override
  _ChatMenuRecommendationState createState() => _ChatMenuRecommendationState();
}

class _ChatMenuRecommendationState extends State<ChatMenuRecommendation> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _chatMessages = [];
  bool showCartButton = false; // 장바구니 버튼 표시 여부를 나타내는 변수
  bool isTyping = false; // 타자기가 보이는지 여부를 나타내는 변수

  Future<String> generateText(String prompt) async {
    final apiKey = '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';
    final endpoint = 'https://api.openai.com/v1/chat/completions';
    final cp949Decoder = Encoding.getByName('cp949');

    messages.add({"role": "user", "content": prompt});

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "messages": messages,
        'max_tokens': 300,
        'temperature': 0.7,
        'model': "gpt-3.5-turbo"
      }),
    );

    if (response.statusCode == 200) {
      final String responseData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonResponse = json.decode(responseData);

      final gptResponse = jsonResponse['choices'][0]['message']['content'];

      // GPT 응답에서 "장바구니" 텍스트 확인
      if (gptResponse.contains("장바구니")) {
        setState(() {
          showCartButton = true; // 장바구니 버튼 표시
        });
      } else {
        setState(() {
          showCartButton = false; // 장바구니 버튼 숨김
        });
      }

      // 타자기를 보이도록 설정
      setState(() {
        isTyping = true;
      });

      return gptResponse;
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

    // 타자기가 사라지도록 설정
    setState(() {
      isTyping = false;
    });

    setState(() {
      _chatMessages.add('GPT: $gptResponse');
    });
  }

  void _navigateToCartPage() {
    // 장바구니 페이지로 이동하는 코드 추가
    // 예를 들어, Navigator를 사용하여 이동할 수 있습니다.
    // Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
    // CartPage는 장바구니 페이지로 대체해야 합니다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주문도우미'),
        backgroundColor: Color.fromARGB(255, 238, 98, 98),
        actions: showCartButton
            ? [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                  Get.to(() => CartScreen());
                }, // 장바구니 페이지로 이동
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB04F4F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fixedSize: Size(200, 100),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      '장바구니',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ]
            : null,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final message = _chatMessages[index];
                final isUserMessage = message.startsWith('사용자:');
                final borderColor = isUserMessage ? Colors.yellow : Color.fromARGB(255, 211, 239, 97);

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor),
                  ),
                  child: ListTile(
                    title: Text(message),
                  ),
                );
              },
            ),
          ),
          // 타자기 표시 여부에 따라 아래 위젯을 표시하거나 숨깁니다.
          if (isTyping)
            CircularProgressIndicator() // 타자기 대신 로딩 인디케이터 표시
          else
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