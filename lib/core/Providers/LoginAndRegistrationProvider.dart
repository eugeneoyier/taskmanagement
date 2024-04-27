import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LoginAndRegistrationProvider {
 final Dio _dio = Dio();

 Future<bool> registerUser(String email, String password) async {
    try {
      final response = await _dio.post(
        'https://maids.pharmchem.co.ke/todo/register.php',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
           Get.toNamed('/login');
        return true;
      } else {
        throw Exception('Failed to register user');
      }
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
 }

 Future<bool> loginUser(String email, String password) async {
    try {
      final response = await _dio.post(
        'https://maids.pharmchem.co.ke/todo/login.php',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        Get.toNamed('/dashboard');
        return true;
      } else {
        throw Exception('Failed to login user');
      }
    } catch (e) {
      throw Exception('Failed to login user: $e');
    }
 }
}
