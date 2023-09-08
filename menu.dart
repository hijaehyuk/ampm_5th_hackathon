import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MenuCategory();
}

class MenuCategory extends State<MyHomePage> {
  bool showBackButton = true;
  bool showCartButton = true;

  final List<CategoryItem> categories = [
    CategoryItem('버거 & 세트', Icons.fastfood_outlined),
    CategoryItem('해피 스낵', Icons.sentiment_satisfied),
    CategoryItem('스낵 & 사이드', Icons.kebab_dining_outlined),
    CategoryItem('음료', Icons.local_cafe_outlined),
    CategoryItem('디저트', Icons.icecream_outlined),
    CategoryItem('해피밀', Icons.takeout_dining_outlined),
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
          IconButton(
            icon: const Icon(Icons.local_mall_outlined),
            color: Color(0xFF4FB07A),
            onPressed: () {
              // Handle cart button press
            },
          ),
        ]
        : null,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '메뉴',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 42,
              decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.room, color: Color(0xFF4FB07A), size: 24),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: ElevatedButton(
                      onPressed: () {
                        // 버튼을 눌렀을 때 실행되는 코드
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4FB07A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fixedSize: Size(54, 32),
                        padding: EdgeInsets.zero,
                      ),
                      child: Align(
                        child: Text(
                            '변경',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
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

class CategoryItem {
  final String title;
  final IconData icon;

  CategoryItem(this.title, this.icon);
}

class CategoryCard extends StatelessWidget {
  final CategoryItem category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Get.to를 사용하여 다음 화면으로 이동
        Get.to(() => MenuSelectionScreen(category: category));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF4FB07A),
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.black.withOpacity(0.5),
        elevation: 8,
      ),
      child: Container(
        width: 147, // 박스 가로 크기
        height: 147, // 박스 세로 크기
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, size: 40),
            SizedBox(height: 10),
            Text(
              category.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 23, // 텍스트 크기
                // fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MenuSelectionScreen extends StatelessWidget {
  final CategoryItem category;

  MenuSelectionScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menuItems = getMenuItemsForCategory(category);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.grey,
          onPressed: () {
            // Navigate back to the main screen
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.local_mall_outlined),
            color: Color(0xFF4FB07A),
            onPressed: () {
              // Handle cart button press
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
            child: Text(
              '${category.title}',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: menuItems.map((menu) {
                  return MenuItemCard(
                    menuInfo: menu,
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 22)
        ],
      ),
    );
  }

  List<Map<String, dynamic>> getMenuItemsForCategory(CategoryItem category) {
    List<Map<String, dynamic>> menuItems = [];

    if (category.title == '버거 & 세트') {
      menuItems = [
        {
          'iconName': 'assets/ChangnyeongGarlicChickenBurger.png',
          'menuName': '창녕 갈릭 치킨 버거',
          'price': '4500원',
          'description' : '100% 국내산 창녕 햇마늘이 듬뿍 들어간\n마늘 토핑과 마늘 아이올리 소스,\n두툼 바삭한 치킨 패티의 환상의 조합!',
        },
        // SizedBox(height: 16),
        {
          'iconName': 'assets/ChangnyeongGarlicBeefBurger.png',
          'menuName': '창녕 갈릭 비프 버거',
          'price': '4500원',
          'description': '100% 국내산 창녕 햇마늘이 듬뿍 들어간\n마늘 토핑과 마늘 아이올리 소스\n육즙 가득한 순 쇠고기 패티 2장의 풍부한 맛!',
        },
        {
          'iconName': 'assets/BigMac.png',
          'menuName': '빅맥®',
          'price': '4500원',
          'description': '100% 순 쇠고기 패티 두 장에 빅맥®만의 특별한 소스. 입안에서 살살 녹는 치즈와 신선한 양상추, 양파, 그리고 피클까지.50년 넘게 전 세계인의 입맛을 사로 잡은 버거의 대명사.',
        },
        {
          'iconName': 'assets/DoubleQuarterPounderwithCheese.png',
          'menuName': '더블 쿼터파운더® 치즈',
          'price': '4500원',
          'description': '좋아하는건 더 많이 즐기시라고,두 배 이상 커진 1/4 파운드 비프 패티가 두 장 (226그램)! 육즙이 풍부한 고기 맛을 그대로 살린 100% 순 쇠고기 패티 두 장과 치즈 두 장이 입안 가득 완벽하게 조화되는 놀라운 맛',
        },
        {
          'iconName': 'assets/QuarterPounderwithCheese.png',
          'menuName': '쿼터파운더® 치즈',
          'price': '4500원',
          'description': '쿼터파운더라는 이름에서 알 수 있듯이\n두 배 이상 커진 1/4파운드(113그램) 비프와\n부드러운 치즈 두 장의 환상궁합!\n두툼한 순 쇠고기 패티와 신선한 치즈의\n풍부한 맛으로 세계적으로 사랑받고 있는\n맥도날드의 대표적인 프리미엄 버거',
        },
        {
          'iconName': 'assets/McCrispyDeluxeBurger.png',
          'menuName': '맥크리스피™ 디럭스\n버거',
          'price': '4500원',
          'description': '100% 통닭다리살 겉바속촉 케이준 치킨 패티, 촉촉한 포테이토 브리오쉬 번, 스페셜 스모키 소스가 선사하는 놀랍도록 새로운 맛의 치킨 버거!',
        },
      ];
    } else if (category.title == '해피 스낵') {
      menuItems = [
        {
          'iconName': 'assets/CajunBeefSnackWrap.png',
          'menuName': '케이준 비프 스낵랩',
          'price': '2500원',
          'description': '매콤한 케이준 소스와 100% 순 쇠고기 패티의 만남',
        },
        {
          'iconName': 'assets/IceAmericano.png',
          'menuName': '아이스 아메리카노',
          'price': '2500원',
          'description': '바로 내린 100% 친환경 커피로 더 신선하게! 더 풍부하게!',
        },
        {
          'iconName': 'assets/IcedVanillaLatte.png',
          'menuName': '아이스 바닐라 라떼',
          'price': '2500원',
          'description': '바로 내린 100% 친환경 커피의 진한 맛과 향, 1A등급 우유, 그리고 천연 바닐라 향으로 달콤함까지!',
        },
        {
          'iconName': 'assets/Coca-ColaZero.png',
          'menuName': '코카-콜라 제로',
          'price': '2500원',
          'description': '상쾌한 맛은 살리면서 웰빙 트렌드에 맞춰 설탕과 칼로리를 제로로 줄인 코카-콜라 제로',
        },
        {
          'iconName': 'assets/Cheeseburger.png',
          'menuName': '치즈 버거',
          'price': '2500원',
          'description': '고소하고 부드러운 치즈와 100% 순 쇠고기 패티, 맥도날드만의 심플한 클래식 치즈버거.',
        },
      ];
    } else if (category.title == '스낵 & 사이드') {
      menuItems = [
        {
          'iconName': 'assets/SomeSideItem.png',
          'menuName': '스낵 & 사이드 메뉴1',
          'price': '3000원',
          'description': '...',
        },
      ];
    } else if (category.title == '음료') {
      menuItems = [
        {
          'iconName': 'assets/SomeSideItem.png',
          'menuName': '음료',
          'price': '3000원',
          'description': '...',
        },
      ];
    } else if (category.title == '디저트') {
      menuItems = [
        {
          'iconName': 'assets/SomeSideItem.png',
          'menuName': '디저트',
          'price': '3000원',
          'description': '...',
        },
      ];
    } else if (category.title == '해피밀') {
      menuItems = [
        {
          'iconName': 'assets/SomeSideItem.png',
          'menuName': '해피밀',
          'price': '3000원',
          'description': '...',
        },
      ];
    }

    return menuItems;
  }
}

class MenuItemCard extends StatelessWidget {
  final Map<String, dynamic> menuInfo;

  MenuItemCard({
    required this.menuInfo,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.to(() => MenuDetailScreen(menuInfo: menuInfo));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
        padding: EdgeInsets.zero,
        shadowColor: Colors.black.withOpacity(0.0), // 그림자 X
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
        child: Container(
          width: double.infinity,
          height: 134,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      menuInfo['iconName'],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 245,
                    child: Text(
                      menuInfo['menuName'],
                      style: TextStyle(color: Colors.black, fontSize: 24),
                      overflow: TextOverflow.visible, // 텍스트를 그냥 보여줌
                    ),
                  ),
                  SizedBox(height: 8), // 텍스트 간격 조절
                  Text(
                    menuInfo['price'],
                    style: TextStyle(fontSize: 20, color: Color(0xFF4FB07A)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuDetailScreen extends StatefulWidget {
  final Map<String, dynamic> menuInfo;

  MenuDetailScreen({
    required this.menuInfo,
  });

  @override
  _MenuDetailScreenState createState() => _MenuDetailScreenState();
}

class _MenuDetailScreenState extends State<MenuDetailScreen> {
  bool isFavorite = false; // 초기 값: 즐겨찾기 되지 않음

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.grey,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.local_mall_outlined),
            color: Color(0xFF4FB07A),
            onPressed: () {
              // Handle cart button press
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true, // body 위에 Appbar
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 360,
            decoration: BoxDecoration(
              color: Color(0xBBF4BD45),
            ),
            child: Center(
              child: Image.asset(
                widget.menuInfo['iconName'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          // SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 11, 11, 0),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: Color(0xFF4FB07A),
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite; // 버튼을 누를 때마다 상태 변경
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.menuInfo['menuName'],
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  widget.menuInfo['description'],
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  overflow: TextOverflow.visible,
                ),
                SizedBox(height: 12),
                Text(
                  widget.menuInfo['price'],
                  style: TextStyle(fontSize: 24, color: Color(0xFF4FB07A)),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SizedBox(
          width: 316,
          height: 45,
          child: ElevatedButton(
            onPressed: () {
              _showAddedToCartDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4FB07A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text(
              "장바구니에 담기",
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
      ),
    );
  }
}

void _showAddedToCartDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 20,
              height: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context); // 다이얼로그 닫기
                },
                icon: Icon(Icons.close, color: Color(0xFF4FB07A)),
                iconSize: 24,
                padding: EdgeInsets.all(0),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "장바구니에 담았습니다.",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 17),
            ElevatedButton(
              onPressed: () {
                // 장바구니 화면으로 이동
                // Navigator.push(context, MaterialPageRoute(builder: (context) => YourCartScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFF4FB07A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Color(0xFF4FB07A), width: 1),
                ),
                fixedSize: Size(272, 45),
                elevation: 0, // 그림자 없애기
              ),
              child: Text("장바구니 가기", style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // MenuCategory 화면으로 이동
                Navigator.pop(context); // 다이얼로그 닫기
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4FB07A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                fixedSize: Size(272, 45),
                elevation: 0, // 그림자 없애기
              ),
              child: Text("다른 메뉴 보기", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
        actions: [],
      );
    },
  );
}


