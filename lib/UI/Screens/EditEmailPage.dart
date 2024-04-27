// EditEmailPage.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/core/Providers/ProfileController.dart';

class EditEmailPage extends StatelessWidget {
  final int userId;

  const EditEmailPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    final TextEditingController emailController = TextEditingController(text: controller.email);
    final TextEditingController usernameController = TextEditingController(text: controller.username);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Email and Username'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'New Email',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'New Username',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.updateUserData(userId: userId, newUsername: usernameController.text, newEmail: emailController.text);
                Get.back();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
