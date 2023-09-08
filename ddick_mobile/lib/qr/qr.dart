import 'package:ddick_mobile/qr/qr_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import '../screens/bag.dart';

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double dashWidth = 5.0;
    final double dashSpace = 5.0;
    final double totalWidth = size.width;
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    double startX = 0.0;
    while (startX < totalWidth) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MySemiCirclePainterRight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xFFB04F4F)
      ..style = PaintingStyle.fill;

    final double radius = 10; // 반원의 반지름

    // 반원을 그릴 위치와 크기를 지정하는 Rect 객체 생성
    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );

    // 오른쪽 반달 모양 반원을 그리기 위한 시작 각도와 페인트 각도 설정
    final double startAngle = -3.1416 / 2; // 시작 각도 (라디안 단위, -90도)
    final double sweepAngle = 3.1416; // 반원의 각도 (180도를 라디안으로 변환)

    // drawArc 메서드를 사용하여 반원 그리기
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MySemiCirclePainterLeft extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xFFB04F4F)
      ..style = PaintingStyle.fill;

    final double radius = 10; // 반원의 반지름

    // 반원을 그릴 위치와 크기를 지정하는 Rect 객체 생성
    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );

    // 오른쪽 반달 모양 반원을 그리기 위한 시작 각도와 페인트 각도 설정
    final double startAngle = 3.1416 / 2; // 시작 각도 (라디안 단위, -90도)
    final double sweepAngle = 3.1416; // 반원의 각도 (180도를 라디안으로 변환)

    // drawArc 메서드를 사용하여 반원 그리기
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class QrScreen extends StatefulWidget {
  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  Map<String, dynamic>? latestCartItem;
  //late Timer _timer;

  final cartService = CartService();

  @override
  void initState() {
    super.initState();
    _loadLatestCartItem();
  }

  Future<void> _loadLatestCartItem() async {
    latestCartItem = await cartService.fetchLatestCartItem();
    setState(() {}); // UI를 업데이트하기 위해 setState 호출
  }

  @override
  void dispose() {
    //_timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double realWidth = screenWidth - 44;
    double realHeight = screenHeight - 116;
    double HminusW = realHeight - realWidth;

    return Scaffold(
        backgroundColor: Color(0xFFB04F4F),
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
//빈공간(상태바)

//상단 네비게이션바
              Column(
                children: [
                  Container(
                      height: 42,
                      width: realWidth,
                      color: Color(0xFFB04F4F),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xFFffffff),
                              size: 30,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.local_mall_outlined,
                              color: Color(0xFFffffff),
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
//상단 네비게이션바 end

//빈공간
              SizedBox(height: 24),
//빈공간

//티켓 - 리스트
              Column(
                children: [
                  //전체흰사각형
                  Container(
                      height: realHeight,
                      width: realWidth,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Positioned(
                              child: Column(
                            children: [
                              // 지점이름 컨테이너
                              Container(
                                  height: 84,
                                  width: realWidth,
                                  child: Row(
                                    children: [
                                      SizedBox(width: 24),
                                      Image.asset(
                                          'assets/images/McDonalds_logo.png',
                                          height: 30,
                                          width: 30),
                                      SizedBox(width: 10),
                                      Text(
                                        '맥도날드 전주덕진DT점',
                                        style: TextStyle(
                                          color: Color(0xFF111111),
                                          fontSize: 22,
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          )),

//사랑해 은재야
                          Positioned(
                              top: 74,
                              left: 22,
                              child: Container(
                                  width: realWidth - 44,
                                  height: HminusW - 14 - 84,
                                  /*child: 여기에 리스트 */
                                  child: ListView.builder(
                                    itemCount:
                                        latestCartItem?['items']?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final item =
                                          latestCartItem?['items'][index];
                                      final quantity = item?['quantity'] ?? 0;
                                      return ListTile(
                                        leading: Image.asset(
                                            item?['iconName'] ?? '',
                                            width: 40,
                                            height: 40), // 아이콘 이미지
                                        title: Text(
                                            item?['menuName'] ?? ''), // 메뉴 이름
                                        trailing:
                                            Text('x${quantity ?? 0}'), // 수량
                                      );
                                    },
                                  ))),
//사랑해 은재야 ㅜㅠㅜㅠ
                          Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                  height: realWidth,
                                  width: realWidth,
                                  color: Color(0xffF2F3F5))),
                          Positioned(
                              top: HminusW,
                              child: CustomPaint(
                                painter: DashedLinePainter(),
                                size: Size(350, 1),
                              )),
                          Positioned(
                              top: HminusW - 5,
                              left: 0,
                              child: CustomPaint(
                                  painter: MySemiCirclePainterRight(),
                                  size: Size(0, 10))),
                          Positioned(
                              top: HminusW - 5,
                              right: 0,
                              child: CustomPaint(
                                painter: MySemiCirclePainterLeft(),
                                size: Size(0, 10),
                              )),
                          Positioned(
                              bottom: (realWidth - 180) / 2,
                              left: (realWidth - 180) / 2,
                              child: Container(
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ))),
                          Positioned(
                            // 원하는 위치에 QR 코드를 배치합니다.
                            bottom: (realWidth - 180) / 2,
                            left: (realWidth - 180) / 2,
                            child: QrImageView(
                              data: latestCartItem?['_id']?.toString() ??
                                  '', // DB의 _id를 가져와 문자열로 변환
                              version: QrVersions.auto,
                              size: 180.0,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
//티켓 - 리스트 end

//괄호막기용
            ])));
  }
}
