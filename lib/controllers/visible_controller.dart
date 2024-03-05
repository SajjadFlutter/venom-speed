import 'package:get/get.dart';

class VisibleController extends GetxController {
  var visible = false.obs;

  void changeVisible(bool newVisible) {
    visible.value = newVisible;
  }
}
