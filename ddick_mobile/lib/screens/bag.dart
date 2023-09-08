import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BagScreen extends StatelessWidget {
  List<Map<String, dynamic>> menuItems = [
      {
        'iconName': 'assets/images/ChangnyeongGarlicChickenBurger.png',
        'menuName': '1955 버거',
        'price': '4500원',
        'description':
            '<재료>\n쇠고기 패티,베이컨,양파,토마토,양상추',
      },
      {
        'iconName': 'assets/images/ChangnyeongGarlicBeefBurger.png',
        'menuName': '빅맥®',
        'price': '5200원',
        'description':
            '<재료>\n쇠고기 패티,베이컨,양파,토마토,양상추',
      },
      {
        'iconName': 'assets/images/BigMac.png',
        'menuName': '맥스파이시 상하이 버거',
        'price': '5000원',
        'description':
            '<재료>\n닭가슴통살,양상추,토마토',
      },
    ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double realWidth = screenWidth - 44;
    double listHeight = screenHeight - 242;

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 22,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//빈공간(상태바)
              SizedBox(
                height: 28,
              ),
//빈공간

//상단 네비게이션바
              Column(
                children: [
                  Container(
                      height: 42,
                      width: realWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xFFB7B7B7),
                              size: 30,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          )
                        ],
                      ))
                ],
              ),
// 네비게이션바 end

//빈공간
              SizedBox(height: 24),
//빈공간

// TiTle - 장바구니
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '장바구니',
                    style: TextStyle(
                      color: Color(0xff111111),
                      fontSize: 28,
                    ),
                  ),
                ],
              ),

// TiTle end

//빈공간
              SizedBox(
                height: 24,
              ),
//빈공간

//위치바
              Column(
                children: [
                  // 전체크기용
                  Container(
                      height: 50,
                      width: realWidth,
                      child: Row(
                        children: [
                          //전체 회색박스
                          Container(
                              height: 50,
                              width: realWidth,
                              decoration: BoxDecoration(
                                color: Color(0xffF2F3F5),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Stack(
                                children: [
                                  //아이콘 pos
                                  Positioned(
                                      left: 10,
                                      top: 10,
                                      child: Icon(
                                        Icons.where_to_vote,
                                        color: Color(0xFFB04F4F),
                                        size: 30,
                                      )),

                                  //위치텍스트 pos
                                  Positioned(
                                      left: 45,
                                      top: 15,
                                      child: Text(
                                        '맥도날드 전주덕진DT점',
                                        style: TextStyle(
                                          color: Color(0xFF111111),
                                          fontSize: 20,
                                        ),
                                      )),

                                  // 변경버튼 pos
                                  Positioned(
                                    right: 10,
                                    top: 9,
                                    child: Container(
                                        width: 54,
                                        height: 32,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFB04F4F),
                                            borderRadius:
                                                BorderRadius.circular(100.0)),
                                        child: Center(
                                            child: Text('변경',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                )))),
                                  )
                                ],
                              ))
                        ],
                      ))
                ],
              ),
//위치바 end

//빈공간
              SizedBox(height: 6),
//빈공간

//장바구니 list
              Column(
                children: [
                  Container(
                      width: realWidth,
                      height: listHeight,
                      child: ListView.builder(
                          itemCount: menuItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            //리스트 커스텀
                            return Container(
                                width: realWidth,
                                height: 104,
                                child: Stack(
                                  children: [
                                    //원 pos
                                    Positioned(
                                        top: 12,
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  spreadRadius: 2,
                                                  blurRadius: 4,
                                                  offset: Offset(0, 2),
                                                )
                                              ]),
                                          /* 이후 수정
                                    child: Center(
                                      child: Image.asset(
                                        iconName,
                                        fit: BoxFit.fill,
                                      )
                                    )
                                    */
                                        )),

                                    //메뉴이름 pos
                                    Positioned(
                                        top: 28,
                                        left: 102,
                                        child:
                                            Text(menuItems[index]['menuName'],
                                                style: TextStyle(
                                                  color: Color(0xFF111111),
                                                  fontSize: 20,
                                                ))),

                                    //가격 pos
                                    Positioned(
                                        top: 58,
                                        left: 102,
                                        child: Text(menuItems[index]['price'],
                                            style: TextStyle(
                                              color: Color(0xFFB04F4F),
                                              fontSize: 18,
                                            ))),

                                    //삭제버튼 pos
                                    Positioned(
                                      top: 12,
                                      right: 0,
                                      child: Container(
                                          width: 62,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFB04F4F),
                                              borderRadius:
                                                  BorderRadius.circular(100.0)),
                                          child: Center(
                                              child: Text('삭제',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  )))),
                                    ),

                                    //수량버튼 pos
                                    Positioned(
                                      top: 57,
                                      right: 0,
                                      child: Container(
                                          width: 88,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFffffff),
                                              border: Border.all(
                                                color: Color(0xFFB04F4F),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(100.0)),
                                          //버튼내부내용
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              //더하기버튼
                                              IconButton(
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Color(0xFFB04F4F),
                                                ),
                                                onPressed: () {
                                                  /*수량더하기*/
                                                },
                                              ),
                                              Text('1',
                                                  style: TextStyle(
                                                    color: Color(0xff111111),
                                                    fontSize: 18,
                                                  )),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Color(0xFFB04F4F),
                                                ),
                                                onPressed: () {
                                                  /*수량빼기*/
                                                },
                                              )
                                            ],
                                          )),
                                    ),
                                    //positioned 추가
                                  ],
                                ));
                          })),
                ],
              ),
//장바구니 list

// 기본틀
/*
              Column(
                children: [
                  Container(
                      height: ,
                      width: ,
                      child: 

                  )
                ],
              ),
*/

//괄호막기용
            ])));
  }
}
