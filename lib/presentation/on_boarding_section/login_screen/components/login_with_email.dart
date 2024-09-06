import 'package:ecommerce_seller/presentation/on_boarding_section/reset_password/reset_password_screen.dart';
import 'package:ecommerce_seller/presentation/widgets/button_widgets.dart';
import 'package:ecommerce_seller/utilz/colors.dart';
import 'package:ecommerce_seller/utilz/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ecommerce_seller/presentation/on_boarding_section/login_screen/controller/login_controller.dart';

class LoginScreenWithEmail extends StatelessWidget {
  LoginScreenWithEmail({super.key});

  // Get the instance of LoginController
  final loginController = Get.put(LoginController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 1.h),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Email',
                labelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.px,
                  color: black,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: black),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter your email',
                hintStyle: TextStyle(
                  color: grey.withOpacity(0.3),
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
            SizedBox(height: Adaptive.h(2)),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Password',
                labelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.px,
                  color: black,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: black),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Password*',
                hintStyle: TextStyle(
                  color: grey.withOpacity(0.3),
                ),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            sizedBoxHeight20,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ResetPassword());
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Forget Your Password?',
                          style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' Reset Here',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.yellow,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Adaptive.h(8)),
            Obx(() {
              return loginController.isLoading.value
                  ? CircularProgressIndicator() // Show loading spinner
                  : InkWell(
                      onTap: () {
                        // Trigger login using the controller
                        loginController.loginUser(
                          emailController.text,
                          passwordController.text,
                        );
                      },
                      child: ButtonWidget(
                        backgroundColor: buttonColor,
                        title: 'Login',
                        textColor: Colors.white,
                        heights: Adaptive.h(6),
                      ),
                    );
            }),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
