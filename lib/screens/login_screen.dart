import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/text_styles.dart';
import '../api_manager.dart';
import '../components/otp/src/otp_pin_field_input_type.dart';
import '../components/otp/src/otp_pin_field_style.dart';
import '../components/otp/src/otp_pin_field_widget.dart';
import '../utils/constants.dart';
import 'main_app.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  TextEditingController pinController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double otpwidth = size.width / 9;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: headingText(17),
              ),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppConstants.textfield,
                    borderRadius: BorderRadius.circular(5)),
                // padding: EdgeInsets.all(8),
                child: TextField(
                  style: normalText(14).copyWith(color: AppConstants.white),
                  controller: emailController,
                  decoration: InputDecoration(
                      hintStyle:
                          normalText(14).copyWith(color: AppConstants.white),
                      hintText: 'Email',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      border: InputBorder.none),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 31),
                child: OtpPinField(
                  otpPinFieldInputType: OtpPinFieldInputType.none,
                  onSubmit: (text) {
                    pinController.text = text;
                  },
                  otpPinFieldStyle: const OtpPinFieldStyle(
                    defaultFieldBorderColor: Colors.white,
                    activeFieldBorderColor: Colors.white,

                    defaultFieldBackgroundColor: Colors.transparent,
                    activeFieldBackgroundColor: Colors
                        .transparent, // Background Color for active/focused Otp_Pin_Field
                  ),
                  maxLength: 6,
                  highlightBorder: false,
                  fieldWidth: otpwidth,
                  fieldHeight: otpwidth,
                  keyboardType: TextInputType.number,
                  autoFocus: true,
                  otpPinFieldDecoration:
                      OtpPinFieldDecoration.defaultPinBoxDecoration,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (loading) return;
                    loading = true;
                    setState(() {});
                    String res = await ApiManager.fetchPost(
                        'events/getEvents',
                        jsonEncode({
                          'email': emailController.text.trim(),
                          'pin': pinController.text.trim(),
                        }));
                    loading = false;
                    setState(() {});
                    if (res.contains('fail')) {
                      Get.snackbar('Hurry!', "Account does'nt exist",
                          colorText: AppConstants.white);
                      return;
                    }
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    await sharedPreferences.setInt(
                        'pin', int.parse(pinController.text.trim()));
                    await sharedPreferences.setString(
                        'email', emailController.text.trim());
                    await sharedPreferences.setString('login', '1');
                    Get.offAll(() => const CalendarApp());
                  },
                  child: Text(loading ? "Checking..." : 'Login'))
            ],
          ),
        ),
      ),
    );
  }
}
