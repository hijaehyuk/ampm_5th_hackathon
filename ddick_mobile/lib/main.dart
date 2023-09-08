import 'package:ddick_mobile/screens/homepage.dart';
import 'package:ddick_mobile/screens/menu_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() => {
        Get.put(CartController())
      }),
      home: MyHomePage(), // 여기에는 앱의 시작 화면 위젯을 넣어주세요.
    ),
  );
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}
