import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/Core/app_color.dart';
import 'package:food_app/Screen/splesh_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:otp_text_field/otp_text_field.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  OtpScreen(
      {super.key, this.verificationId, this.phoneNumber, this.resendingToken});
  final String? verificationId;
  final String? phoneNumber;
  int? resendingToken;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  // ignore: override_on_non_overriding_member
  OtpFieldController otp = OtpFieldController();
  Timer? _timer;
  int _start = 0;
  bool error = false;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    // ignore: unnecessary_new
    _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_start >= 60) {
                timer.cancel();
              } else {
                _start += 1;
              }
            }));
  }

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
            hasError: error,
            width: 80.w,
            keyboardType: TextInputType.phone,
            otpFieldStyle: OtpFieldStyle(
              focusBorderColor: AppColor.darkIndigo,
            ),
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
            onChanged: (pin) {},
            onCompleted: (pin) async {
              if (_start >= 60) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('code Expired')));
              } else {
                if (widget.verificationId != null) {
                  AuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId!, smsCode: pin);
                  try {
                    if (credential.providerId != '') {
                      await FirebaseAuth.instance
                          .signInWithCredential(credential)
                          .then((value) {
                        Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SpleshScreen()))
                            .then((value) async {
                          await FirebaseFirestore.instance
                              .collection("Users")
                              .add({"Number": widget.phoneNumber, "cart": []});
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setBool('login', true);
                        });
                      });
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid otp')));
                    setState(() {
                      error = true;
                    });
                  }
                }
              }
            },
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
                onPressed: () {
                  setState(() {
                    otp.clear();
                    _start = 0;
                    startTimer();
                    sendOTP();
                  });
                },
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

  sendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? _resendToken) async {
        verificationId = widget.verificationId!;
        widget.resendingToken = _resendToken;
      },
      timeout: const Duration(seconds: 60),
      forceResendingToken: widget.resendingToken,
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
      },
    );
    debugPrint("_verificationId: ${widget.verificationId}");
    return true;
  }
}
