import 'package:ddick_mobile/screens/basket.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;

  void addToCart(Map<String, dynamic> item) {
    cartItems.add(item);
  }

  void incrementQuantity(int index) {
    var item = cartItems[index];
    item['quantity'] = (item['quantity'] ?? 1) + 1;
    cartItems[index] = item;
  }

  // 수량 감소 메서드
  void decrementQuantity(int index) {
    var item = cartItems[index];
    item['quantity'] = (item['quantity'] ?? 1) - 1;

    if (item['quantity'] <= 0) {
      cartItems.removeAt(index); // 수량이 0 이하면 항목 제거
    } else {
      cartItems[index] = item;
    }
  }
}

class MenuDetailScreen extends StatefulWidget {
  List<Map<String, dynamic>> menuItems = [
    {
      'iconName': 'assets/images/ChangnyeongGarlicChickenBurger.png',
      'menuName': '1955 버거',
      'price': '4500원',
      'description': '<재료>\n쇠고기 패티,베이컨,양파,토마토,양상추',
    },
    {
      'iconName': 'assets/images/ChangnyeongGarlicBeefBurger.png',
      'menuName': '빅맥®',
      'price': '5200원',
      'description': '<재료>\n쇠고기 패티,베이컨,양파,토마토,양상추',
    },
    {
      'iconName': 'assets/images/BigMac.png',
      'menuName': '맥스파이시 상하이 버거',
      'price': '5000원',
      'description': '<재료>\n닭가슴통살,양상추,토마토',
    },
  ];

  @override
  _MenuDetailScreenState createState() => _MenuDetailScreenState();
}

class _MenuDetailScreenState extends State<MenuDetailScreen> {
  int _currentIndex = 0;
  bool isFavorite = false; // 초기 값: 즐겨찾기 되지 않음

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _addToCartAndRedirect() {
    final cartController = Get.put(CartController());

    Map<String, dynamic> currentItem = widget.menuItems[_currentIndex];

    // 장바구니에 아이템 추가
    cartController.addToCart({
      'iconName': currentItem['iconName'],
      'menuName': currentItem['menuName'],
      'price': currentItem['price'],
    });

    // 장바구니 화면으로 이동
    Get.to(() => CartScreen());

    _showAddedToCartDialog(context);
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
                  icon: Icon(Icons.close, color: Color(0xFFB04F4F)),
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
                  _addToCartAndRedirect();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFFB04F4F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Color(0xFFB04F4F), width: 1),
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
                  backgroundColor: Color(0xFFB04F4F),
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

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentItem = widget.menuItems[_currentIndex];
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
            color: Color(0xFFB04F4F),
            onPressed: () {
              Get.to(() => CartScreen());
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: widget.menuItems.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 360,
                    decoration: BoxDecoration(
                      color: Color(0xBBF4BD45),
                    ),
                    child: Center(
                      child: Image.asset(
                        widget.menuItems[index]['iconName'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 11, 11, 0),
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.star : Icons.star_border,
                            color: Color(0xFFB04F4F),
                            size: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
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
                          widget.menuItems[index]['menuName'],
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.menuItems[index]['description'],
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                          overflow: TextOverflow.visible,
                        ),
                        SizedBox(height: 12),
                        Text(
                          widget.menuItems[index]['price'],
                          style:
                              TextStyle(fontSize: 25, color: Color(0xFFB04F4F)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SizedBox(
          width: 316,
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              _showAddedToCartDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFB04F4F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text(
              "장바구니에 담기",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
