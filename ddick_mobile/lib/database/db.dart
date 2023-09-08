// database_manager.dart
import 'package:mongo_dart/mongo_dart.dart';

class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager._internal();
  Db? _db;

  factory DatabaseManager() {
    return _instance;
  }

  DatabaseManager._internal();

  Future<Db> get db async {
    if (_db == null) {
      _db = await Db.create(
        'mongodb+srv://hjs123:qwer1234@cluster0.ymcer3e.mongodb.net/?retryWrites=true&w=majority',
      );
      await _db!.open();
    }
    return _db!;
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}

