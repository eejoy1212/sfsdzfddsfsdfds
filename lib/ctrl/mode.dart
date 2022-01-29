import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  void switchTheme(int index) {
    Get.changeThemeMode(index == 0 ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}

class Themes {
  static final light = ThemeData(
    appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
  );
  static final dark = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF15202B),
    shadowColor: Colors.black26,
    // backgroundColor: wrColors.wrDarkbg,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyText2: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: const Color(0xff37383a),
    ),
  );
}
