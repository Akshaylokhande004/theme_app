import 'package:mobx/mobx.dart';
import 'package:theme_app/db/db.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  @observable
  bool isDark = db.isDarkTheme();

  @action
  void toggleTheme(bool isDark) {
    this.isDark = isDark;
    db.setTheme(isDark);
  }
}
