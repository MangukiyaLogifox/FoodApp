import 'package:flutter/material.dart';
import 'package:food_app/Core/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int increment = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.darkIndigo,
      ),
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
            SizedBox(height: 1.h),
            Image.asset(
              'assets/image/Splesh.png',
              height: 22.h,
            ),
            SizedBox(height: 10.2.h),
            productdetail()
          ],
        ),
      ),
    );
  }

  Widget productdetail() {
    return Container(
      height: 54.4.h,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(60))),
      child: Padding(
        padding: EdgeInsets.only(
          top: 3.h,
          left: 6.w,
          right: 6.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 5.h,
                  width: 20.5.w,
                  decoration: BoxDecoration(
                      color: AppColor.darkIndigo,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColor.yellow,
                      ),
                      Text(
                        '4.8',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 2.8.h,
                            color: AppColor.white),
                      )
                    ],
                  ),
                ),
                Text(
                  '\$20',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 2.8.h,
                      color: AppColor.yellow),
                )
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Text(
                  'Beef Burger',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 2.6.h,
                      color: AppColor.black),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    if (increment > 0) {
                      setState(() {
                        increment--;
                      });
                    }
                  },
                  child: cbutton(Icons.remove),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 10.w,
                  child: Text(
                    '$increment',
                    style:
                        TextStyle(fontSize: 2.3.h, color: AppColor.darkIndigo),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      increment++;
                    });
                  },
                  child: cbutton(Icons.add),
                )
              ],
            ),
            SizedBox(height: 1.5.h),
            Text(
              'Big juicy beef burger with cheese, lettuce, tomato, onions and special sauce !',
              style: GoogleFonts.poppins(fontSize: 2.3.h),
            ),
            SizedBox(height: 1.4.h),
            Text(
              'Add ons',
              style: GoogleFonts.poppins(
                  fontSize: 2.3.h, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 1.4.h),
            SizedBox(
              height: 10.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(left: 0.w, right: 14.w),
                      child: Stack(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              height: 8.8.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                color: AppColor.white60,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.asset(
                                'assets/image/Splesh.png',
                                height: 8.h,
                              )),
                          Positioned(
                            bottom: 7.5,
                            right: 0.00,
                            child: CircleAvatar(
                                backgroundColor: AppColor.green,
                                radius: 9,
                                child: Icon(
                                  Icons.add,
                                  color: AppColor.white,
                                  size: 2.h,
                                )),
                          )
                        ],
                      ));
                },
              ),
            ),
            SizedBox(height: 1.h),
            // Container(
            //   height: 50,
            //   width: 80,
            //   decoration: BoxDecoration(color: AppColor.darkIndigo),
            // )
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: AppColor.darkIndigo,
                      padding: EdgeInsets.symmetric(
                          vertical: 1.5.h, horizontal: 17.w)),
                  onPressed: () {},
                  child: Text(
                    'Add to cart',
                    style: GoogleFonts.poppins(
                        fontSize: 3.h, fontWeight: FontWeight.w600),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget cbutton(IconData icon) {
    return CircleAvatar(
        radius: 10,
        backgroundColor: AppColor.darkIndigo,
        child: CircleAvatar(
            backgroundColor: AppColor.white,
            radius: 8,
            child: Icon(
              icon,
              size: 2.h,
            )));

    // );
  }
}
