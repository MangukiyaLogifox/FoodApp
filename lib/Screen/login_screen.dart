import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/Core/app_color.dart';
import 'package:food_app/Screen/otp_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScren extends StatefulWidget {
  const LoginScren({super.key});

  @override
  State<LoginScren> createState() => _LoginScrenState();
}

class _LoginScrenState extends State<LoginScren> {
  var dialCode = '+91';
  bool show = false;
  var verificationId = '';
  TextEditingController phoneNumber = TextEditingController();
  @override
  void dispose() {
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 58.w,
            ),
            child: Container(
              height: 140,
              width: 300,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(2000),
                    topLeft: Radius.circular(110)),
                color: AppColor.darkIndigo,
                shape: BoxShape.rectangle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 54.w),
            child: Text(
              'Welcome',
              style: GoogleFonts.poppins(
                  color: AppColor.lightIndigo,
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 17.w),
            child: Text(
              'Login/ Create an account',
              style: GoogleFonts.poppins(
                  color: AppColor.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 19.sp),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 53.w),
            child: Text(
              'Phone Number',
              style: GoogleFonts.poppins(
                  color: AppColor.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp),
            ),
          ),
          SizedBox(
              width: 85.w,
              height: 8.h,
              child: IntlPhoneField(
                controller: phoneNumber,
                flagsButtonPadding: const EdgeInsets.all(8),
                keyboardType: TextInputType.phone,
                cursorColor: AppColor.darkIndigo,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                dropdownTextStyle: const TextStyle(color: AppColor.darkIndigo),
                dropdownIconPosition: IconPosition.trailing,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColor.darkIndigo)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColor.darkIndigo)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColor.red)),
                ),
                onCountryChanged: (value) {
                  dialCode = value.dialCode;
                },
                initialCountryCode: 'IN',
                invalidNumberMessage: 'Please enter a valid number',
                onChanged: (phone) {},
              )),
          SizedBox(height: 1.9.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: show == false
                  ? AppColor.darkIndigo
                  : AppColor.lightIndigo.withOpacity(0.5),
              padding: EdgeInsets.symmetric(vertical: 1.9.h, horizontal: 30.w),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            onPressed: () async {
              show == false ? _verifyPhone() : '';
              setState(() {
                show = true;
              });
            },
            child: const Text('Send OTP'),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 60.w),
            child: Container(
              height: 130,
              width: 380,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(130),
                  topRight: Radius.circular(4900),
                ),
                color: AppColor.darkIndigo,
                shape: BoxShape.rectangle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: dialCode + phoneNumber.text,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        },
        codeSent: (String verificationID, int? resendingToken) {
          setState(() {
            verificationId = verificationID;
            // ignore: avoid_single_cascade_in_expression_statements
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("OTP Sent")))
                .closed
              ..then((value) => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtpScreen(
                                  verificationId: verificationId,
                                  phoneNumber: dialCode + phoneNumber.text,
                                  resendingToken: resendingToken,
                                )))
                  });
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            verificationId = verificationID;
          });
        });
  }
}
