import 'package:flutter/material.dart';
import 'package:food_app/Core/app_color.dart';
import 'package:food_app/Screen/dash_board_Screen.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SpleshScreen extends StatefulWidget {
  // ignore: unused_field
  late bool _seen;

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          AppColor.darkIndigo,
          AppColor.lightIndigo,
        ])),
        child: Column(
          children: [
            SizedBox(height: 17.h),
            image(),
            SizedBox(height: 3.h),
            text('Enjoy'),
            text('Your Food'),
            SizedBox(
              height: 8.h,
            ),
            getStartedButton()
          ],
        ),
      ),
    );
  }

  Widget image() {
    return Image.asset(
      'assets/image/Splesh.png',
      height: 38.h,
      width: 80.h,
    );
  }

  Widget text(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: AppColor.white, fontWeight: FontWeight.w600, fontSize: 38.sp),
    );
  }

  Widget getStartedButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            primary: AppColor.white,
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 7.w)),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const DashBoardScreen()));
        },
        child: Text(
          'Get Started',
          style: GoogleFonts.poppins(
              color: AppColor.darkIndigo,
              fontWeight: FontWeight.w600,
              fontSize: 22.sp),
        ));
  }
}
