import 'package:flutter/material.dart';
import 'package:food_app/Core/app_color.dart';
import 'package:food_app/Screen/splesh_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductioneScreen extends StatefulWidget {
  bool? _seen;
  IntroductioneScreen({super.key});

  @override
  IntroductioneScreenState createState() => IntroductioneScreenState();
}

class IntroductioneScreenState extends State<IntroductioneScreen> {
  checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', true);
  }

  @override
  late List<IntroductioneModel> introduction = [
    IntroductioneModel(
        image: 'assets/image/food.png',
        text: 'Quality food',
        desc:
            'Food quality is the quality characteristics of food that is acceptedable to consumers.we Provide best Quality food in town.'),
    IntroductioneModel(
        image: 'assets/image/availabel.png',
        text: 'Fast delivery',
        desc:
            'We provide the fastest delivery system.we will reach food in your home within 30 minutes.'),
    IntroductioneModel(
        image: 'assets/image/24.png',
        text: '24/7 Service',
        desc:
            '24 hours delivery service that you can eat your food anytime when u get hungry.'),
  ];

  var introductionPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            AppColor.scaffold,
            AppColor.scaffold,
          ],
        )),
        child: Column(
          children: [
            SizedBox(height: 15.h),
            Image.asset(
              introduction[introductionPage].image.toString(),
              height: 30.h,
              width: 70.w,
            ),
            SizedBox(height: 10.h),
            Text(introduction[introductionPage].text.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 4.h)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 2.h),
              child: Text(
                introduction[introductionPage].desc.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 2.1.h),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 2.w, top: 3.h),
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: introductionPage == index
                            ? AppColor.darkIndigo
                            : AppColor.grey,
                      ),
                    );
                  },
                )),
            SizedBox(height: 2.h),
            if (introductionPage != 2) ...[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColor.darkIndigo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(horizontal: 10.w)),
                  onPressed: () {
                    setState(() {
                      if (introductionPage <= 3) introductionPage++;
                    });
                  },
                  child: Text(
                    'Next',
                    style: GoogleFonts.poppins(fontSize: 4.w),
                  )),
              TextButton(
                onPressed: () {
                  setState(() {
                    introductionPage = 2;
                  });
                },
                child: Text(
                  'Skip',
                  style: GoogleFonts.poppins(
                      color: AppColor.darkIndigo,
                      fontWeight: FontWeight.w600,
                      fontSize: 4.w),
                ),
              )
            ],
            if (introductionPage == 2) ...[
              SizedBox(height: 1.5.h),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColor.darkIndigo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(horizontal: 10.w)),
                  onPressed: () {
                    checkFirstSeen();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SpleshScreen()));
                  },
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(),
                  )),
            ]
          ],
        ),
      ),
    );
  }
}
// onPressed: () => _onIntroEnd(context),

class IntroductioneModel {
  String? image;
  String? text;
  String? desc;
  IntroductioneModel({this.image, this.text, this.desc});
}
