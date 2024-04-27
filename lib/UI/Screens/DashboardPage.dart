import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatelessWidget {

   Future<String> getNameFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? 'John Doe'; // Default name if not found
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 103, 43, 206),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           FutureBuilder<String>(
          future: getNameFromSharedPreferences(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator while waiting
            } else {
              return Text(
                'Welcome, ${snapshot.data}!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              );
            }
          },
        ),
            SizedBox(height: 20),
            _buildTaskItem(Icons.check, 'Tasks Completed: 5'),
            SizedBox(height: 10),
            _buildTaskItem(Icons.close, 'Tasks Not Yet Done: 3'),
            SizedBox(height: 20),
            Text(
              'Daily Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            _buildDataVisualization(),
            SizedBox(height: 20),
            Text(
              'Recent Activities',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            _buildRecentActivities(),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: icon == Icons.check ? Colors.green : Colors.red),
        title: Text(title, style: TextStyle(fontSize: 18, color: Colors.deepPurple)),
      ),
    );
  }

  Widget _buildDataVisualization() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.deepPurpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text('Data Visualization Here', style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }

  Widget _buildRecentActivities() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3 / 2,
      children: List.generate(4, (index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text('Activity ${index + 1}', style: TextStyle(fontSize: 18, color: Colors.deepPurple)),
          ),
        );
      }),
    );
  }
}
