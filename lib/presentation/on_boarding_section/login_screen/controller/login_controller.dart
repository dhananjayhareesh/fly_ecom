import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var isLoading = false.obs; // To manage loading state
  var token = ''.obs; // To store token
  var userId = ''.obs; // To store user id
  RxString selectedValue = 'Login'.obs;

  // Function to change the selected login method (Mobile or Email)
  changingSelectedOption(String login) {
    selectedValue.value = login;
  }

  // Function to handle login
  Future<void> loginUser(String email, String password) async {
    isLoading(true);

    try {
      // API URL
      final url =
          Uri.parse('https://sanjay-tiwari-backend.vercel.app/api/user/login');

      // Send POST request with email and password
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Check if the status is 200 (login successful)
        if (data['status'] == 200) {
          token.value = data['token']; // Store token
          userId.value = data['data']['_id']; // Store user ID

          Get.snackbar('Login Success', 'Welcome back!',
              snackPosition: SnackPosition.BOTTOM);

          // Now you can use token and userId in other requests like cart functionality.
        } else {
          Get.snackbar('Error', data['message'],
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar('Error', 'Invalid credentials',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred during login',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
