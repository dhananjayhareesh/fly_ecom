import 'package:ecommerce_seller/presentation/main_section/home_screen/cart/controller/cart_controller.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/cart/payment/payment_screen.dart';
import 'package:ecommerce_seller/presentation/main_section/notification/notification_screen.dart';
import 'package:ecommerce_seller/presentation/main_section/search_screen/search_screen.dart';
import 'package:ecommerce_seller/presentation/widgets/bottomsheet_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../utilz/colors.dart';
import '../../../../utilz/sized_box.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      body: Obx(
        () {
          if (cartController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (cartController.cartItems.isEmpty) {
            return Center(child: Text('No items in your cart'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: Adaptive.h(20),
                  width: Adaptive.w(100),
                  color: chatColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      sizedBoxHeight50,
                      Row(
                        children: [
                          sizedBoxWidth40,
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 17.sp,
                            ),
                          ),
                          Text(
                            'My Cart',
                            style: GoogleFonts.poppins(
                                fontSize: 18.px, fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const NotificationScreen());
                            },
                            child: Image.asset('assets/images/appbar1.png'),
                          ),
                          sizedBoxWidth30,
                          GestureDetector(
                            onTap: () {
                              showCustomBottomSheet(context);
                            },
                            child: Image.asset('assets/images/appbar2.png'),
                          ),
                          sizedBoxWidth30,
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const SearchScreen());
                        },
                        child: Container(
                          height: Adaptive.h(6),
                          width: Adaptive.w(90),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Search your products...',
                                style: GoogleFonts.poppins(
                                    color: grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.px),
                              ),
                              Spacer(),
                              Icon(
                                Icons.search,
                                color: buttonColor,
                              ),
                              sizedBoxWidth20,
                              Container(
                                height: Adaptive.h(2),
                                width: Adaptive.w(0.4),
                                color: grey,
                              ),
                              sizedBoxWidth20,
                              Image.asset('assets/images/home2.png'),
                              sizedBoxWidth15
                            ],
                          ),
                        ),
                      ),
                      sizedBoxHeight20,
                    ],
                  ),
                ),
                sizedBoxHeight20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Deliver to :',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.px,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff838383)),
                                        ),
                                        TextSpan(
                                          text: 'Jay Kumar... 411045',
                                          style: GoogleFonts.poppins(
                                              fontSize: 13.px,
                                              fontWeight: FontWeight.w500,
                                              color: black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizedBoxWidth10,
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Color(0xffF2F2F2)),
                                    child: Text(
                                      'Home',
                                      style: GoogleFonts.poppins(
                                          fontSize: 11.px,
                                          fontWeight: FontWeight.w400,
                                          color: black),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Q.No. Room number 201, Epic, Vishal...',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.px,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff838383)),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: Adaptive.h(6),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.sp),
                              border: Border.all(
                                color: buttonColor,
                              ),
                              color: whiteColor,
                            ),
                            child: Center(
                              child: Text(
                                'Change',
                                style: GoogleFonts.poppins(
                                    fontSize: 13.px,
                                    color: buttonColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cartController.cartItems.length,
                          itemBuilder: (context, index) {
                            final cartItem = cartController.cartItems[index];
                            final productId = cartItem['id'];
                            final currentQuantity = cartItem['quantity'];
                            final product =
                                cartController.cartItems[index]['product'];

                            return Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: grey.withOpacity(0.2))),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                              'assets/images/cart1.png'),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (cartController
                                                          .currentQuantity
                                                          .value >
                                                      1) {
                                                    // Decrement quantity
                                                    cartController
                                                        .updateCartQuantity(
                                                            cartController
                                                                    .currentQuantity
                                                                    .value -
                                                                1);
                                                  }
                                                },
                                                child: Image.asset(
                                                    'assets/images/cartdic.png'),
                                              ),
                                              const SizedBox(width: 20),
                                              Obx(() => Text(
                                                    '${cartController.currentQuantity.value}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              const SizedBox(width: 20),
                                              GestureDetector(
                                                onTap: () {
                                                  // Increment quantity
                                                  cartController
                                                      .updateCartQuantity(
                                                          cartController
                                                                  .currentQuantity
                                                                  .value +
                                                              1);
                                                },
                                                child: Image.asset(
                                                    'assets/images/cartincr.png'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(product['productName']),
                                          sizedBoxHeight10,
                                          Row(
                                            children: [
                                              VxRating(
                                                size: Adaptive.h(2),
                                                count: 5,
                                                isSelectable: false,
                                                selectionColor: buttonColor,
                                                onRatingUpdate: (value) {},
                                              ),
                                              Text(
                                                '56890',
                                                style: TextStyle(
                                                    color: grey,
                                                    fontSize: 12.px),
                                              ),
                                              sizedBoxWidth20,
                                              Text(
                                                'MOQ:4 Pcs',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.px),
                                              ),
                                            ],
                                          ),
                                          sizedBoxHeight10,
                                          Row(
                                            children: [
                                              Text(
                                                '6500',
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.black26,
                                                    fontSize: 15.px,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              sizedBoxWidth10,
                                              Text(
                                                '₹ 949',
                                                style: TextStyle(
                                                    color: black,
                                                    fontSize: 15.px,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              sizedBoxWidth60,
                                              Text(
                                                '74% off',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15.px,
                                                    color: Colors.green),
                                              ),
                                            ],
                                          ),
                                          sizedBoxHeight10,
                                          Text(
                                            '2 offers applied 2 offers available ',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.px,
                                                color: Colors.green),
                                          ),
                                          sizedBoxHeight10,
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: 'Free Delivery',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12.px,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.green)),
                                            TextSpan(
                                                text: 'by Thu Mar 28 | ',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13.px,
                                                    fontWeight: FontWeight.w500,
                                                    color: grey)),
                                            TextSpan(
                                                text: ' ₹ 40',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13.px,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.red))
                                          ])),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                      'Size: ${cartController.cartItems[index]['size']}'),
                                  GestureDetector(
                                    onTap: () async {
                                      // Confirm deletion
                                      bool confirm = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Confirm Deletion'),
                                            content: Text(
                                                'Are you sure you want to delete this item from the cart?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                                child: Text('Yes'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: Text('No'),
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                      if (confirm) {
                                        // Call delete API
                                        final productId =
                                            cartController.cartItems[index]
                                                ['product']['productId'];
                                        await cartController
                                            .deleteCartProductById(productId);
                                      }
                                    },
                                    child: Container(
                                      height: Adaptive.h(5),
                                      width: Adaptive.w(25),
                                      decoration: BoxDecoration(
                                          color: red,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          'Remove',
                                          style: GoogleFonts.poppins(
                                              color: whiteColor,
                                              fontSize: 12.px),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            '\$${cartController.cartItems[index]['totalAmount']}'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          // Confirm deletion
                          bool confirm = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Deletion'),
                                content: Text(
                                    'Are you sure you want to delete this item from the cart?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text('Yes'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text('No'),
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirm) {
                            cartController.deleteCart();
                          }
                        },
                        child: Container(
                          height: Adaptive.h(5),
                          width: Adaptive.w(25),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 21, 59, 196),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              'Remove Cart',
                              style: GoogleFonts.poppins(
                                  color: whiteColor, fontSize: 12.px),
                            ),
                          ),
                        ),
                      ),
                      sizedBoxHeight10,
                      Container(
                        height: 50,
                        color: Color(0xffF2F2F2),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Adaptive.w(70),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Add ${cartController.cartItems.length} more items to save extra 20% off',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14.px,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.green),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(20),
                              child: Center(
                                child: Text(
                                  'VIEW ALL',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15.px,
                                      fontWeight: FontWeight.w500,
                                      color: buttonColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 15),
            Text(
              '₹ 949',
              style: GoogleFonts.poppins(
                  fontSize: 18.px,
                  fontWeight: FontWeight.w500,
                  color: buttonColor),
            ),
            SizedBox(width: 15),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const PaymentScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'PROCEED TO CHECKOUT',
                style: GoogleFonts.poppins(
                    fontSize: 15.px, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
