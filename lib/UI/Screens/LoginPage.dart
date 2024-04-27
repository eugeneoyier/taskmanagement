import 'package:flutter/material.dart';
import 'package:todo/UI/custom_widgets/CustomButton.dart';
import 'package:todo/UI/custom_widgets/CustomText.dart';
import 'package:todo/UI/custom_widgets/CustomTextField.dart';
import 'package:todo/core/Providers/LoginAndRegistrationProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
 @override
 _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 final TextEditingController _emailController = TextEditingController();
 final TextEditingController _passwordController = TextEditingController();
 final LoginAndRegistrationProvider _provider = LoginAndRegistrationProvider();

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: CustomText(text: 'Welcome to My Tasks Application', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))), // Customized AppBar title
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content
            children: [
              // Add your logo here
              Image.asset('images/logo.png', width: 300, height: 300),
              SizedBox(height: 24), // Add some space between the logo and the form
              Container(
                decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(10), // Border radius for the container
                 boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                 ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                 children: [
                    CustomTextField(
                      controller: _emailController,
                      showIcon: false,
                      hintText: 'Email',
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                    ),
                    SizedBox(height: 16),
                 CustomButton(
 text: 'Login',
 action: () async {
      Get.dialog(CircularProgressIndicator());
    try {
      bool success = await _provider.loginUser(_emailController.text, _passwordController.text);
      if (success) {
        // Store email in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', _emailController.text);
        // Optionally, navigate to another page or show a success message
      } else {
        // Handle login failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    } catch (e) {
      // Handle any exceptions thrown by loginUser
          Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
 },
),

             
                    SizedBox(height: 24), // Add some space between the form and the signup link
                    InkWell(
                      onTap: () {
                        Get.toNamed('/signup'); // Assuming '/signup' is the route for the signup page
                      },
                      child: Text(
                        'Don\'t have an account? Sign up',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                 ],
                ),
              ),
              SizedBox(height: 16), // Add some space between the card and the button
            ],
          ),
        ),
      ),
    );
 }
}