import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/Core/app_color.dart';
import 'package:food_app/Screen/splesh_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  OtpScreen({super.key, this.verificationId, this.phoneNumber});
  String? verificationId;
  String? phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  // ignore: override_on_non_overriding_member
  OtpFieldController otp = OtpFieldController();
  var temp;
  final bool autoFocus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: EdgeInsets.only(right: 36.w),
            child: Text(
              'Waiting for the otp',
              style: GoogleFonts.poppins(
                  color: AppColor.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 19.sp),
            ),
          ),
          SizedBox(height: 2.h),
          OTPTextField(
            isDense: true,
            controller: otp,
            hasError: true,
            width: 80.w,
            keyboardType: TextInputType.phone,
            otpFieldStyle: OtpFieldStyle(
                focusBorderColor: AppColor.darkIndigo,
                errorBorderColor: Colors.red),
            obscureText: false,
            inputFormatter: [
              LengthLimitingTextInputFormatter(6),
            ],
            length: 6,
            style: const TextStyle(
              fontSize: 17,
            ),
            spaceBetween: Checkbox.width,
            fieldStyle: FieldStyle.underline,
            onChanged: (pin) {
              print("Changed: " + pin);
            },
            onCompleted: (pin) {
              print("Completed: " + pin);
              // signInWithPhoneNumber(widget.verificationId.toString(), pin);
              if (widget.verificationId != null) {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId!,
                    smsCode: otp.toString());
                var res =
                    FirebaseAuth.instance.signInWithCredential(credential);
                print("RES::::::::::::${res.toString()}");
              }
            },
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'Resend OTP',
                  style: GoogleFonts.poppins(
                      color: AppColor.lightIndigo,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp),
                )),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 60.w),
            child: Container(
              height: 130,
              width: 380,
              decoration: BoxDecoration(
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

  // FirebaseAuth auth = FirebaseAuth.instance;
  // Future signInWithPhoneNumber(String verificationId, String smsCode) async {
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: verificationId,
  //     smsCode: smsCode,
  //   );
  //   await auth.signInWithCredential(credential);
  //   // ignore: use_build_context_synchronously
  //   Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => SpleshScreen()))
  //       .catchError((e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Invalid otp')));
  //     Navigator.pop(context);
  //   });
  //   await FirebaseFirestore.instance
  //       .collection("Users")
  //       .add({"Number": widget.phoneNumber, "cart": []});
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('login', true);
  // }
}
