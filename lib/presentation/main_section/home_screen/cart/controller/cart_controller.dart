import 'package:ecommerce_seller/presentation/main_section/home_screen/cart/cart_screen.dart';
import 'package:ecommerce_seller/presentation/on_boarding_section/login_screen/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartController extends GetxController {
  var isLoading = false.obs;

  Future<void> addToCart(String productId) async {
    isLoading(true);
    final token = Get.find<LoginController>().token.value;

    final url =
        Uri.parse('https://sanjay-tiwari-backend.vercel.app/api/user/cart/add');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'productId': productId,
          'size': 'S',
          'quantity': 1,
        }),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Item added to cart');
        Get.to(() => CartScreen());
      } else {
        var errorData = jsonDecode(response.body);
        String errorMessage = errorData['message'] ?? 'Unknown error';
        Get.snackbar('Error', 'Failed to add item to cart: $errorMessage');
        print('Error: $errorMessage');
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      Get.snackbar('Error', 'Failed to add item to cart: $e');
      print('Exception: $e'); // Log the exception for debugging
    } finally {
      isLoading(false);
    }
  }

  var cartItems = [].obs; // Observable list to store cart items

  Future<void> fetchCartItems() async {
    isLoading(true);
    final token = Get.find<LoginController>().token.value;

    final url =
        Uri.parse('https://sanjay-tiwari-backend.vercel.app/api/user/cart/get');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Parse the response body and update cartItems
        var responseData = jsonDecode(response.body);
        cartItems.assignAll(responseData['data']['products']);
        Get.snackbar('Success', 'Cart retrieved successfully');
      } else {
        var errorData = jsonDecode(response.body);
        String errorMessage = errorData['message'] ?? 'Unknown error';
        Get.snackbar('Error', 'Failed to retrieve cart: $errorMessage');
        print('Error: $errorMessage');
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      Get.snackbar('Error', 'Failed to retrieve cart: $e');
      print('Exception: $e'); // Log the exception for debugging
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCartItems(); // Fetch cart items when the controller is initialized
  }
}
