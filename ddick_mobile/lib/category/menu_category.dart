import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../category/category_item_model.dart';
import '../screens/basket.dart';
import '../screens/homepage.dart';
import 'category_card.dart';
import '../screens/gpt.dart';

class MenuCategory extends State<MyHomePage> {
  bool showBackButton = true;
  bool showCartButton = true;

  final List<CategoryItem> categories = [
    CategoryItem('즐겨찾기'),
    CategoryItem('햄버거'),
    CategoryItem('음료'),
    CategoryItem('디저트'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.grey,
                onPressed: () {
                  // Navigate back to the main screen
                  Navigator.pop(context);
                },
              )
            : null,
        actions: showCartButton
            ? [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0), 
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => CartScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB04F4F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fixedSize: Size(100, 50), 
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
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Changed this to spaceBetween
          crossAxisAlignment: CrossAxisAlignment.center, // Centered items horizontally
          children: [
            Center(
              child: Text(
                '메뉴',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  mainAxisSpacing: 22, 
                  crossAxisSpacing: 22, 
                  childAspectRatio: (147 / 147),
                ),
                itemCount: categories.length,
                itemBuilder: (ctx, index) {
                  return CategoryCard(
                    category: categories[index],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0), // Added padding to give some space at the bottom
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => ChatMenuRecommendation());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB04F4F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fixedSize: Size(400, 200), 
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  '주문도우미',
                  style: TextStyle(color: Colors.white, fontSize: 60),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
