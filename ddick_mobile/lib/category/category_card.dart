import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'category_item_model.dart';
import '../screens/menu_detail.dart';

class CategoryCard extends StatelessWidget {
  final CategoryItem category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Get.to를 사용하여 다음 화면으로 이동
        Get.to(() => MenuDetailScreen());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 248, 248, 248),
        foregroundColor: Color(0xFFB04F4F),
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Color(0xFFB04F4F).withOpacity(1),
        elevation: 15,
      ),
      child: Container(
        width: 147, // 박스 가로 크기
        height: 147, // 박스 세로 크기
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(category.icon, size: 40),
            // SizedBox(height: 10),
            Text(
              category.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 35, // 텍스트 크기
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
