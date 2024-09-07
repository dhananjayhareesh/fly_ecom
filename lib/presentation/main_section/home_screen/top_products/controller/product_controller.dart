import 'package:ecommerce_seller/presentation/on_boarding_section/login_screen/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductController extends GetxController {
  var products = [].obs;
  var isLoading = true.obs;
  final LoginController loginController = Get.find<LoginController>();
  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('https://sanjay-tiwari-backend.vercel.app/api/user/products'),
        headers: {
          'Authorization': 'Bearer ${loginController.token.value}',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        products.value = jsonData['data'];
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
