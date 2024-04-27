import 'package:get/get.dart';

class BottomNavbarController extends GetxController {
 var tabIndex = 0.obs;

 void tabChange(int index) {
    tabIndex.value = index;
 }
}
