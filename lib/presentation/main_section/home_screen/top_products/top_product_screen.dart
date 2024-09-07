import 'package:ecommerce_seller/presentation/main_section/home_screen/top_products/controller/product_controller.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/top_products/filter_by_clicking_top_product/filter_screen.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/top_products/product_screen/product_details_screen.dart';
import 'package:ecommerce_seller/presentation/main_section/notification/notification_screen.dart';
import 'package:ecommerce_seller/utilz/colors.dart';
import 'package:ecommerce_seller/utilz/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class TopProductScreen extends StatelessWidget {
  TopProductScreen({super.key});

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios, size: 16.px)),
        title: Text(
          'Top Products',
          style:
              GoogleFonts.poppins(fontSize: 18.px, fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.to(() => NotificationScreen());
              },
              child: Image.asset('assets/images/appbar1.png')),
          sizedBoxWidth20,
          Image.asset('assets/images/appbar2.png'),
          sizedBoxWidth20,
          Image.asset('assets/images/appbar3.png'),
          sizedBoxWidth20,
        ],
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 5, // Spacing between columns
                mainAxisSpacing: 9.0, // Spacing between rows
                childAspectRatio: 0.75,
              ),
              itemCount: productController.products.length,
              itemBuilder: (context, index) {
                var product = productController.products[index];
                return InkWell(
                  onTap: () {
                    print(
                        'Navigating to ProductDetailsScreen with product ID: ${product['_id']}');
                    Get.to(() => ProductDetailsScreen(
                          productId: product['_id'],
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(255, 230, 227, 227),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100.w,
                          child: Image.network(
                            product['image'][0]['url'],
                            fit: BoxFit.cover,
                            width: 100.w,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            product['productName'],
                            style: TextStyle(
                                color: black,
                                fontSize: 13.px,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              Text(
                                '₹${product['discountPrice']}',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 13.px,
                                    fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                              Text(
                                'MOQ: 4 Pcs',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.px),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            VxRating(
                              count: 5,
                              selectionColor: buttonColor,
                              value: (product['rating'] as num).toDouble(),
                              onRatingUpdate: (value) {},
                            ),
                            Text(
                              '${product['numOfReviews']}',
                              style: TextStyle(color: grey, fontSize: 12.px),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
