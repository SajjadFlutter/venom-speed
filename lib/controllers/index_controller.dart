import 'package:get/get.dart';

class IndexController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int newIndex) {
    selectedIndex.value = newIndex;
  }
}
