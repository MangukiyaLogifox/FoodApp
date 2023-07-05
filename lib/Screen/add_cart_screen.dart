import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Core/app_color.dart';
import 'package:food_app/Screen/dash_board_Screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class AddCartScreen extends StatefulWidget {
  const AddCartScreen({super.key});

  @override
  State<AddCartScreen> createState() => _AddCartScreenState();
}

class _AddCartScreenState extends State<AddCartScreen> {
  getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await prefs.getString('phonenumber');
    print("::::::::$data");
  }

  void initState() {
    getPhoneNumber();
    getCardData();
    super.initState();
  }

  int increment = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.h),
              Text(
                '${cartDataList.length} items in cart',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: 3.h),
              ),
              SizedBox(height: 3.h),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: cartDataList.length,
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
                            child: CachedNetworkImage(
                              imageUrl:cartDataList[index]['image'],
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                      color: AppColor.darkIndigo),
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartDataList[index]['name'],
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500, fontSize: 2.h),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                '\$' + cartDataList[index]['price'],
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
                                      cartDataList[index]['Qty'].toString(),
                                      style: TextStyle(
                                          fontSize: 2.3.h,
                                          color: AppColor.darkIndigo),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        itemQuantatiIncrement(
                                            image: cartDataList[index]['image'],
                                            name: cartDataList[index]['name'],
                                            price: cartDataList[index]['price'],
                                            index: index,
                                            qty: cartDataList[index]['Qty']++);
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
                          InkWell(
                            onTap: () {
                              removeCart(
                                  image: cartDataList[index]['image'],
                                  name: cartDataList[index]['name'],
                                  price: cartDataList[index]['price'],
                                  qty: cartDataList[index]['Qty']);
                            },
                            child: Padding(
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
                            ),
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

  List cartDataList = [];

  getCardData() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        cartDataList = value.data()?['cart'];
      });
    });
  }

  Future removeCart(
      {String? image, String? name, String? price, int? qty}) async {
    Map<String, dynamic> data = {
      "image": image.toString(),
      "name": name.toString(),
      "price": price.toString(),
      "Qty": qty,
    };
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({
      "cart": FieldValue.arrayRemove([data])
    }).then((value) {
      getCardData();
    });
  }
  itemQuantatiIncrement(
      {String? image,
      String? name,
      String? price,
      int? qty,
      int? index}) async {
    Map<String, dynamic> data = {
      "image": image.toString(),
      "name": name.toString(),
      "price": price.toString(),
      "Qty": qty,
    };

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        for (int i = 0; i < value.data()?['cart'].length; i++) {
          if (index == i) {
            FirebaseFirestore.instance
                .collection("Users")
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .update({
              "cart": FieldValue.arrayUnion([qty.toString()])
            }).then((value) {
              getCardData();
            });
          }
        }
      });
    });
  }
}
