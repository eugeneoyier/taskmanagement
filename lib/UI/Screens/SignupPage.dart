import 'package:flutter/material.dart';
import 'package:todo/UI/custom_widgets/CustomButton.dart';
import 'package:todo/UI/custom_widgets/CustomText.dart';
import 'package:todo/UI/custom_widgets/CustomTextField.dart';
import 'package:todo/core/Providers/LoginAndRegistrationProvider.dart';

class SignupPage extends StatefulWidget {
 @override
 _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
 final TextEditingController _emailController = TextEditingController();
 final TextEditingController _passwordController = TextEditingController();
 final TextEditingController _confirmPasswordController = TextEditingController();

 final LoginAndRegistrationProvider _provider = LoginAndRegistrationProvider();

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Create Your Account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), // Customized AppBar title
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
                    CustomTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                    ),
                    SizedBox(height: 16),
                    CustomButton(
                      text: 'Signup',
                      action: () async {
                        if (_passwordController.text != _confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Passwords do not match. Please try again.')),
                          );
                        } else {
                          bool success = await _provider.registerUser(_emailController.text, _passwordController.text);
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Signup successful. Please login.')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Signup failed. Please try again.')),
                            );
                          }
                        }
                      },
                    ),
                    SizedBox(height: 16), // Add some space between the button and the text
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: CustomText(
                        text: 'Already have an account? Login',
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