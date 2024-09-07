import 'package:ecommerce_seller/presentation/main_section/home_screen/cart/cart_screen.dart';
import 'package:ecommerce_seller/presentation/on_boarding_section/login_screen/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartController extends GetxController {
  var isLoading = false.obs;
  var cartItems = [].obs;
  var addedProductIds = <String>[].obs;
  var currentQuantity = 1.obs;
  var currentProductId = ''.obs;

  Future<void> addToCart(String productId) async {
    isLoading(true);
    currentProductId.value = productId;
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
          'quantity': currentQuantity.value,
        }),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        addedProductIds.add(productId);
        Get.snackbar('Success', 'Item added to cart');
        Get.to(() => CartScreen());
      } else {
        var errorData = jsonDecode(response.body);
        String errorMessage = errorData['message'] ?? 'Unknown error';
        Get.snackbar('Error', 'Failed to add item to cart: $errorMessage');
        print('Error: $errorMessage');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add item to cart: $e');
      print('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

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
      Get.snackbar('Error', 'Failed to retrieve cart: $e');
      print('Exception: $e'); // Log the exception for debugging
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteCartProductById(String productId) async {
    isLoading(true);
    final token = Get.find<LoginController>().token.value;

    final url = Uri.parse(
        'https://sanjay-tiwari-backend.vercel.app/api/user/cart/products/$productId');

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        cartItems.removeWhere((item) => item['id'] == productId);
        addedProductIds.remove(productId);
        Get.snackbar('Success', 'Product removed from cart');
      } else {
        var errorData = jsonDecode(response.body);
        String errorMessage = errorData['message'] ?? 'Unknown error';
        Get.snackbar(
            'Error', 'Failed to remove product from cart: $errorMessage');
        print('Error: $errorMessage');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove product from cart: $e');
      print('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateCartQuantity(int quantity) async {
    isLoading(true);
    final token = Get.find<LoginController>().token.value;

    final url = Uri.parse(
        'https://sanjay-tiwari-backend.vercel.app/api/user/cart/updateQuantity');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'productId': currentProductId.value,
          'quantity': quantity,
        }),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        final index = cartItems
            .indexWhere((item) => item['id'] == currentProductId.value);
        if (index != -1) {
          cartItems[index]['quantity'] = quantity;
          cartItems.refresh();
        }
        Get.snackbar('Success', 'Cart quantity updated');
      } else {
        var errorData = jsonDecode(response.body);
        String errorMessage = errorData['message'] ?? 'Unknown error';
        Get.snackbar('Error', 'Failed to update cart quantity: $errorMessage');
        print('Error: $errorMessage');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update cart quantity: $e');
      print('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  Future<void> deleteCart() async {
    isLoading(true);
    final token = Get.find<LoginController>().token.value;

    final url = Uri.parse(
        'https://sanjay-tiwari-backend.vercel.app/api/user/cart/delete');

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        cartItems.clear();
        addedProductIds.clear();
        Get.snackbar('Success', 'Cart deleted successfully');
      } else {
        var errorData = jsonDecode(response.body);
        String errorMessage = errorData['message'] ?? 'Unknown error';
        Get.snackbar('Error', 'Failed to delete cart: $errorMessage');
        print('Error: $errorMessage');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete cart: $e');
      print('Exception: $e');
    } finally {
      isLoading(false);
    }
  }
}
