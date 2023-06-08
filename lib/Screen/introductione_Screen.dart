import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_app/Core/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class IntroductioneScreen extends StatefulWidget {
  const IntroductioneScreen({super.key});

  @override
  State<IntroductioneScreen> createState() => _IntroductioneScreenState();
}

class _IntroductioneScreenState extends State<IntroductioneScreen> {
  var initialPage;

  @override
  void initState() {
    initialPage = 0;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider(
        items: [
          commonSlider('assets/image/food.json', 'Order Food'),
          //2nd Image of Slider
          commonSlider('assets/image/food.json', 'Choose Online'),

          //3rd Image of Slider
          commonSlider('assets/image/food.json', 'Free Delivery')
        ],

        //Slider Container properties
        options: CarouselOptions(
            height: 780.0,
            enlargeCenterPage: true,
            initialPage: initialPage,
            autoPlay: false,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 1,
            scrollPhysics: const NeverScrollableScrollPhysics()),
      ),
    );
  }

  Widget commonSlider(
    String image,
    String text,
  ) {
    return Container(
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Lottie.asset(image),
          SizedBox(height: 6.h),
          Text(
            text,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, fontSize: 2.5.h),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Recipe contests are like our BID constantly-in-progress dinner party-and you're invited.",
              style: GoogleFonts.poppins(fontSize: 3.h),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding:
                      EdgeInsets.symmetric(vertical: 0..h, horizontal: 10.w),
                  primary: AppColor.darkIndigo),
              onPressed: () {
                setState(() {
                  initialPage = 1;

                  print("PAGE:::::${initialPage}");
                });
              },
              child: Text(
                'Next',
                style: GoogleFonts.poppins(color: Colors.white),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                'Skip',
                style: TextStyle(color: AppColor.darkIndigo),
              ))
        ],
      ),
    );
  }
}
