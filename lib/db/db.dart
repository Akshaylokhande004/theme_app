import 'package:hive_flutter/hive_flutter.dart';

class DB {
  late Box _box;

  /// initialise database
  Future<void> init() async {
    // initialise database
    await Hive.initFlutter();
    // open hive box
    _box = await Hive.openBox('mobx_learning');
  }

  final String _isDark = 'isDark';

  bool isDarkTheme() {
    return _box.get(_isDark) as bool? ?? false;
  }

  Future<void> setTheme(bool isDark) async {
    await _box.put(_isDark, isDark);
  }
}

final db = DB();
