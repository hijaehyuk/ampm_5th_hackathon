import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../database/db.dart';
import 'package:flutter/services.dart';
import '../qr/qr.dart';
import 'menu_detail.dart';
class CartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CartScreen(),
    );
  }
}

class BasketCartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
}

class CartScreen extends StatelessWidget {
  final cartController = Get.find<CartController>();

  void _addItemsToDatabase() async {
    final db = await DatabaseManager().db;
    final document = {
      'id': 100 + Random().nextInt(901),
      'items': cartController.cartItems,
    };
    await db.collection('cart').insertOne(document);
    cartController.cartItems.clear();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      
      body: Obx(() {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 37.0, left: 22.0, right: 22.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFFB7B7B7)),
              onPressed: () {
                Navigator.pop(context); // 뒤로가기 버튼 기능
              },
            ),
            // Icon(Icons.shopping_bag, color: Color(0xFFB04F4F), size: 24.0),
          ],
        ),
      ),
      Center(
  child: Text(
    '장바구니',
    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
  ),
),
 Expanded(
  child: cartController.cartItems.isEmpty
      ? Center(child: Text('장바구니가 비어있습니다.'))
      : ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) {
            final item = cartController.cartItems[index];
            return ListTile(
              leading: Image.asset(item['iconName']),
              title: Text(item['menuName']),
              subtitle: Text('가격: ${item['price']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      cartController.decrementQuantity(index); // 수량 감소
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // 빨간색
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // 여백 조절
                      minimumSize: Size(0, 0), // 크기 최소값 설정
                    ),
                    child: Text('빼기', style: TextStyle(fontSize: 16)),
                  ),
                  Text('수량: ${item['quantity'] ?? 1}', style: TextStyle(fontSize: 18)),
                  ElevatedButton(
                    onPressed: () {
                      cartController.incrementQuantity(index); // 수량 증가
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // 초록색
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // 여백 조절
                      minimumSize: Size(0, 0), // 크기 최소값 설정
                    ),
                    child: Text('추가', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            );
          },
        ),
),



      if (!cartController.cartItems.isEmpty)
        ElevatedButton(
  onPressed: () {
    _addItemsToDatabase();
    Get.to(() => QrScreen());
  },
  style: ButtonStyle(
    minimumSize: MaterialStateProperty.all(Size(200, 100)), // 버튼의 최소 크기 설정
    backgroundColor: MaterialStateProperty.all(Color(0xFFB04F4F)), // 원하는 배경색으로 설정
  ),
  child: Text(
    '주문하기',
    style: TextStyle(fontSize: 30),
  )
)


    ],
  );
}),
    );
  }
}