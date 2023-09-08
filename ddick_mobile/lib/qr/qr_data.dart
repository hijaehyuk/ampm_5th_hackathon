import 'package:mongo_dart/mongo_dart.dart';
import 'package:ddick_mobile/database/db.dart';

class CartService {
  Future<Map<String, dynamic>?> fetchLatestCartItem() async {
    final db = await DatabaseManager().db;

    // DB 연결 상태 확인
    while (db.state == State.OPENING) {
      await Future.delayed(Duration(milliseconds: 100));
    }

    if (db.state != State.OPEN) {
      await db.open();
    }

    return await db.collection('cart').findOne(
      where.sortBy('_id', descending: true).limit(1)
    );
  }
}

