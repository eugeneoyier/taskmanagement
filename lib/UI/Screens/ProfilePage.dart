import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/Providers/ProfileController.dart';

import 'EditEmailPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Get.put(ProfileController()); // Register the controller
    _fetchUsernameAndFetchData();
  }

  Future<void> _fetchUsernameAndFetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username != null) {
      Get.find<ProfileController>().fetchData(username);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    controller.fetchData('username'); // Assuming 1 is the user ID

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetBuilder<ProfileController>(
            builder: (controller) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://example.com/user-avatar.jpg'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        controller.username,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Email: ${controller.email}',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.edit, color: Colors.blue),
                          title: Text('Edit Profile',
                              style: TextStyle(color: Colors.blue)),
                          onTap: () {
                            Get.to(() => EditEmailPage(
                                userId: 1)); // Assuming 1 is the user ID
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'About',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'John Doe is a passionate developer and a lover of Flutter. He has been working in the tech industry for over 5 years and is always eager to learn new technologies and improve his skills.',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Skills',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: <Widget>[
                          Chip(
                            label: Text('Flutter',
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.blue,
                          ),
                          Chip(
                            label: Text('Dart',
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.blue,
                          ),
                          Chip(
                            label: Text('Android',
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.blue,
                          ),
                          Chip(
                            label: Text('iOS',
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
