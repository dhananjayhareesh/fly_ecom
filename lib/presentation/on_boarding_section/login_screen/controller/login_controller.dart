import 'dart:convert';
import 'package:ecommerce_seller/presentation/main_section/bottom_navigation/bottom_navigation_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var isLoading = false.obs;
  var token = ''.obs;
  var userId = ''.obs;
  RxString selectedValue = 'Login'.obs;

  changingSelectedOption(String login) {
    selectedValue.value = login;
  }

  Future<void> loginUser(String email, String password) async {
    isLoading(true);

    try {
      final url =
          Uri.parse('https://sanjay-tiwari-backend.vercel.app/api/user/login');
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
        if (data['status'] == 200) {
          token.value = data['token'];
          userId.value = data['data']['_id'];

          // Show success message
          Get.snackbar('Login Success', 'Welcome back!',
              snackPosition: SnackPosition.BOTTOM);

          // Navigate to HomeScreen (replace login screen)
          Get.offAll(() => BottomNavigation());
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
