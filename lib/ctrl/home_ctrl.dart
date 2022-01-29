import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCtrl extends GetxController {
  HomeCtrl get to => Get.find();
  bool isDark = false;
  late PageController pageCtrl;
  RxInt currentIndex = 0.obs;
  GlobalKey bottomNavKey = GlobalKey();
  List<String> dropdownList = ['일 별', '주 별', '월 별'].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageCtrl = PageController();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    pageCtrl.dispose();
  }

  void changeTheme(state) {
    if (state == true) {
      Get.changeTheme(ThemeData.light());
    } else {
      Get.changeTheme(ThemeData.dark());
    }
    update();
  }
}
