import 'package:ddick_mobile/screens/bag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double realWidth = screenWidth - 44;

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

//상태바
              Column(
                children: [
                  Container(
                      height: 42,
                      width: realWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.local_mall_outlined,
                              color: Color(0xFF4FB07A),
                              size: 30,
                            ),
                            onPressed: () {
                              Get.to(BagScreen());
                            },
                          ),
                        ],
                      ))
                ],
              ),
//상태바 end

//빈공간
              SizedBox(height: 24),
//빈공간

// TiTle - 즐겨찾기
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '즐겨찾기',
                    style: TextStyle(
                      color: Color(0xff111111),
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
// TiTle - 즐겨찾기 end

//위치바

//전체틀
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
