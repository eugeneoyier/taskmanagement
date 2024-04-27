import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/UI/Screens/LoginPage.dart';
import 'package:todo/UI/Screens/SignupPage.dart';
import 'package:todo/core/Providers/ProfileController.dart';
import 'package:todo/core/constants/Navigation.dart';

void main() {
  Get.lazyPut(() => ProfileController());
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo List App',
      initialRoute: '/',
         debugShowCheckedModeBanner: true,
      getPages: [
        GetPage(name: '/', page: () => SignupPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/dashboard', page: () => BottomNavbarView()),
        // GetPage(name: '/dashboard', page: () => DashboardScreen()),
        //  GetPage(name: '/tasks', page: () => TasksScreen()),
        // GetPage(name: '/profile', page: () => ProfileScreen()),
      ],
    );
  }
}
