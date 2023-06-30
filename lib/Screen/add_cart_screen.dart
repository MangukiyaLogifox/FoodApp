import 'package:flutter/material.dart';
import 'package:food_app/Core/app_color.dart';
import 'package:food_app/Screen/dash_board_Screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AddCartScreen extends StatefulWidget {
  const AddCartScreen({super.key});

  @override
  State<AddCartScreen> createState() => _AddCartScreenState();
}

class _AddCartScreenState extends State<AddCartScreen> {
  int increment = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7.h),
            Text(
              '2 items in cart',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 3.h),
            ),
            SizedBox(height: 3.h),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                          height: 13.h,
                          width: 21.w,
                          decoration: BoxDecoration(
                              color: AppColor.white60,
                              borderRadius: BorderRadius.circular(20)),
                          child: Image.asset('assets/image/Splesh.png'),
                        ),
                        SizedBox(width: 3.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pizza Fries',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, fontSize: 2.h),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              '\$32',
                              style: GoogleFonts.poppins(
                                  color: AppColor.yellow,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 2.h),
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              children: [
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
                                    style: TextStyle(
                                        fontSize: 2.3.h,
                                        color: AppColor.darkIndigo),
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
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 0.5.w),
                          child: CircleAvatar(
                              radius: 10,
                              backgroundColor: AppColor.red,
                              child: CircleAvatar(
                                  backgroundColor: AppColor.white,
                                  radius: 8,
                                  child: Icon(
                                    Icons.close,
                                    color: AppColor.red,
                                    size: 2.h,
                                  ))),
                        )
                      ],
                    ),
                    SizedBox(height: 1.h),
                  ],
                );
              },
            ),
            Text(
              'Payment Method',
              style: GoogleFonts.poppins(
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 2.h),
            ),
            SizedBox(height: 1.5.h),
            paymentCard(),
            total('Subtotal', '\$52', AppColor.gre, AppColor.gre, 2.h, 2.h),
            total('Tax 10%', '\$5', AppColor.gre, AppColor.gre, 2.h, 2.h),
            total('Total', '\$57', AppColor.black, AppColor.yellow, 3.h, 3.h),
            SizedBox(height: 4.h),
            orderBtn(),
            SizedBox(height: 2.h),
            backMeuBtn()
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

  Widget paymentCard() {
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Container(
          alignment: Alignment.center,
          height: 5.h,
          width: 19.w,
          decoration: BoxDecoration(
              color: AppColor.white, borderRadius: BorderRadius.circular(12)),
          child: Text(
            'Visa',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 2.5.h),
          ),
        ),
        title: Text(
          'Jenius card',
          style: GoogleFonts.poppins(
              color: AppColor.black,
              fontWeight: FontWeight.w500,
              fontSize: 2.h),
        ),
        subtitle: Text('1234 5678 ****'),
        trailing: Icon(Icons.arrow_forward_ios_sharp),
      ),
    );
  }

  Widget total(String text, String text1, Color color, Color colors, var hight,
      var hight1) {
    return SizedBox(
      height: 5.h,
      child: ListTile(
        leading: Text(
          text,
          style: GoogleFonts.poppins(
              color: color, fontWeight: FontWeight.w400, fontSize: hight),
        ),
        trailing: Text(
          text1,
          style: GoogleFonts.poppins(
              color: colors, fontWeight: FontWeight.w600, fontSize: hight1),
        ),
      ),
    );
  }

  Widget orderBtn() {
    return Center(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(vertical: 1.7.h, horizontal: 27.w),
              primary: AppColor.darkIndigo),
          onPressed: () {},
          child: Text(
            'Order',
            style: GoogleFonts.poppins(
                fontSize: 3.2.h, fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget backMeuBtn() {
    return Center(
      child: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashBoardScreen()));
          },
          child: Text(
            'Back to Menu',
            style: TextStyle(
                color: AppColor.black,
                fontSize: 2.5.h,
                fontWeight: FontWeight.w400),
          )),
    );
  }
}
