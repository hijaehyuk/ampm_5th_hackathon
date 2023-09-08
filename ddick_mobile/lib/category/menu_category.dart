import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../category/category_item_model.dart';
import '../screens/basket.dart';
import '../screens/homepage.dart';
import 'category_card.dart';

class MenuCategory extends State<MyHomePage> {
  bool showBackButton = true;
  bool showCartButton = true;

  final List<CategoryItem> categories = [
    CategoryItem('즐겨찾기'),
    CategoryItem('햄버거'),
    // CategoryItem('스낵 & 사이드', Icons.kebab_dining_outlined),
    CategoryItem('음료'),
    CategoryItem('디저트'),
    // CategoryItem('@@@', Icons.takeout_dining_outlined),
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
                      vertical: 8.0), // 버튼의 상하 간격을 조절하기 위해 추가
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => CartScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB04F4F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fixedSize: Size(80, 32), // 버튼 크기 조절. 필요에 따라 변경하십시오.
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
  child: Text(
    '메뉴',
    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
  ),
),

            SizedBox(height: 70),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 가로로 2개의 아이템을 정렬
                  mainAxisSpacing: 22, // 수직 간격 설정
                  crossAxisSpacing: 22, // 수평 간격 설정
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
          ],
        ),
      ),
    );
  }
}
