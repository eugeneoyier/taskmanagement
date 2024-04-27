import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/UI/Screens/DashboardPage.dart';
import 'package:todo/UI/Screens/ProfilePage.dart';
import 'package:todo/UI/Screens/TasksPage.dart';
import 'package:todo/core/constants/BottomNavbarController.dart';

class BottomNavbarView extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    final BottomNavbarController controller = Get.put(BottomNavbarController());

    return Scaffold(
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            onTap: (index) => controller.tabChange(index),
            currentIndex: controller.tabIndex.value,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          )),
      body: Obx(() => IndexedStack(
            index: controller.tabIndex.value,
            children: [
              DashboardPage(),
              TasksPage(),
              ProfilePage(),
            ],
          )),
    );
 }
}
