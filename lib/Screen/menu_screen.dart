// ignore: unused_import
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Common/common_image.dart';
import 'package:food_app/Core/app_color.dart';
import 'package:food_app/Screen/detail_screen.dart';
import 'package:food_app/model/product_category_model.dart';
import 'package:food_app/model/product_model.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

bool seen = false;

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String productName = 'All';
  int tappedIndex = 0;

  @override
  void initState() {
    getProductData();
    getProductCategoryData(productName);
    super.initState();
    tappedIndex = 0;
  }

  var productCatogery = [];
  Future getProductData() async {
    await FirebaseFirestore.instance.collection("FoodApp").get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          productCatogery.add(ProductModel(
              image: element.data()['image'], name: element.data()['name']));
        });
      });
    });
  }

  var productCatogeryList = <ProductCategoeryModel>[];
  Future getProductCategoryData(String productName) async {
    await FirebaseFirestore.instance
        .collection("FoodApp")
        .doc(productName.toString())
        .collection(productName.toString())
        .get()
        .then((value) {
      print("VALUE:::::::::::${value.docs.length}");
      productCatogeryList.clear();
      value.docs.forEach((element) {
        setState(() {
          productCatogeryList.add(ProductCategoeryModel(
            image: element.data()['image'],
            name: element.data()['name'],
            price: element.data()['price'],
            desc: element.data()['desc'],
            rating: element.data()['rating'],
            id: element.data()['id'],
          ));
        });
        print("LISt :::::${productCatogeryList.length}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.bg,
      body: Padding(
        padding: EdgeInsets.only(
          left: 7.w,
          top: 5.h,
          right: 7.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),
            header(),
            SizedBox(height: 3.h),
            textFormField(),
            SizedBox(height: 2.h),
            // seen == true ? CircularProgressIndicator() :
            listviwe(),
            cText('Promotions'),
            offer(),
            SizedBox(height: 1.h),
            cText('Popular'),
            SizedBox(height: 1.h),
            popular(),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Menu',
          style: GoogleFonts.poppins(
              color: AppColor.black,
              fontWeight: FontWeight.w400,
              fontSize: 35.sp),
        ),
        CircleAvatar(
          radius: 21.sp,
          child: Image.asset(
            'assets/image/profile.png',
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  Widget textFormField() {
    return TextFormField(
      cursorColor: AppColor.grey,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: AppColor.grey,
          size: 3.h,
        ),
        hintText: 'Search',
        hintStyle: GoogleFonts.poppins(
            color: AppColor.grey, fontWeight: FontWeight.w400, fontSize: 18.sp),
        contentPadding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 6.w),
        fillColor: AppColor.white60,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: AppColor.white60,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white)),
      ),
    );
  }

  Widget listviwe() {
    return SizedBox(
      // color: AppColor.darkIndigo,
      height: 15.h,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: productCatogeryList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              // setState(() {
              tappedIndex = index;
              getProductCategoryData(productCatogery[index].name);
              // });
            },
            child: Padding(
              padding: EdgeInsets.only(left: 2.5.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonImage(
                    color: tappedIndex == index
                        ? AppColor.darkIndigo
                        : AppColor.white60,
                    height: 8.h,
                    width: 18.5.w,
                    image: productCatogery[index].image,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    productCatogery[index].name,
                    style: GoogleFonts.poppins(
                        color: tappedIndex == index
                            ? AppColor.darkIndigo
                            : AppColor.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget offer() {
    return SingleChildScrollView(
      child: Container(
        height: 14.5.h,
        width: 90.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(begin: Alignment.topCenter, colors: [
              AppColor.blue,
              AppColor.blue1,
            ])),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 0.2.h),
                  Text(
                    '''Today's offers''',
                    style: GoogleFonts.poppins(
                        color: AppColor.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp),
                  ),
                  Text(
                    'Free box of fries',
                    style: GoogleFonts.poppins(
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19.sp),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 53.w,
                      // color: Colors.red,
                      child: Text(
                        'On all order above \$150',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AppColor.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.2.h),
                ],
              ),
              Image.asset(
                'assets/image/French-fries.png',
                height: 11.h,
                width: 11.h,
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cText(
    String text,
  ) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: AppColor.black, fontWeight: FontWeight.w400, fontSize: 25.sp),
    );
  }

  Widget popular() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: GridView.builder(
            // shrinkWrap: true,
            itemCount: productCatogeryList.length,
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 30,
                crossAxisCount: 2,
                crossAxisSpacing: 50,
                childAspectRatio: 2 / 2.5),
            itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailScreen(
                                id: productCatogeryList[index].id,
                                name: productCatogeryList[index].name,
                                image: productCatogeryList[index].image,
                                desc: productCatogeryList[index].desc,
                                price: productCatogeryList[index].price,
                                rating: productCatogeryList[index].rating,
                              ))),
                  child: Container(
                    width: 8.w,
                    // height: 17.h,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(colors: [
                          Color(0xFfEBE8E8),
                          Color(0xFFEFEEEE),
                        ])),
                    child: Column(
                      children: [
                        SizedBox(height: 1.h),
                        CommonImage(
                          height: 9.h,
                          width: 27.5.w,
                          image: productCatogeryList[index].image.toString(),
                          color: AppColor.white60,
                        ),
                        Text(
                          productCatogeryList[index].name.toString(),
                          style: GoogleFonts.poppins(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 13.sp),
                        ),
                        SizedBox(height: 1.5.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${productCatogeryList[index].price.toString()}',
                                style: GoogleFonts.poppins(
                                    color: AppColor.yellow,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp),
                              ),
                              CircleAvatar(
                                  backgroundColor: AppColor.green,
                                  radius: 1.5.h,
                                  child: const Center(
                                      child: Icon(
                                    Icons.add,
                                    color: AppColor.white,
                                  ))),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}
