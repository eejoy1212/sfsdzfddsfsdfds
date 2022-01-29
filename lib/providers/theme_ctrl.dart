import 'package:get/get.dart';

class ThemeSettingCtrl extends GetxController {
  ThemeSettingCtrl get to => Get.find();
  RxBool isChanged = false.obs;
}
