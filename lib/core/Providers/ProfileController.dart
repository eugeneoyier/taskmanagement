// ProfileController.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final String apiUrl = 'https://maids.pharmchem.co.ke/todo/update_email.php';
  final Dio _dio = Dio();

  String username = '';
  String email = '';

  Future<void> fetchData(String username) async {
    try {
      final response = await _dio.get('$apiUrl?username=$username');
      final data = response.data;
      this.username = data['username'];
      email = data['email'];
      update(); // Notify listeners
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> updateUserData({required int userId, String? newUsername, String? newEmail}) async {
    try {
      final Map<String, dynamic> data = {
        'user_id': userId,
      };
      if (newUsername != null) {
        data['username'] = newUsername;
        username = newUsername; // Update local username
      }
      if (newEmail != null) {
        data['email'] = newEmail;
        email = newEmail; // Update local email
      }

      final response = await _dio.put(
        apiUrl,
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update user data');
      }
      update(); // Notify listeners
    } catch (e) {
      print('Error updating user data: $e');
    }
  }
}
