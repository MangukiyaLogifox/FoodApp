import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Core/app_color.dart';
import 'package:food_app/Screen/detail_screen.dart';
import 'package:food_app/model/product_model.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  var list = [];
  Future getData() async {
    await FirebaseFirestore.instance.collection("FoodApp").get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          list.add(ProductModel(
              image: element.data()['image'], name: element.data()['name']));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 2.5.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   padding: EdgeInsets.all(5.sp),
                //   decoration: BoxDecoration(
                //       color: AppColor.white60,
                //       borderRadius: BorderRadius.circular(15)),
                //   height: 9.h,
                //   child: Image.network(
                //     list[index].image,
                //     width: 60,
                //   ),
                // ),
                CachedNetworkImage(
                  imageUrl: list[index].image,
                  imageBuilder: (context, imageProvider) => Container(
                    padding: EdgeInsets.all(5.sp),
                    height: 8.h,
                    width: 18.5.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: imageProvider),
                        color: AppColor.white60,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  // placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  list[index].name,
                  style: GoogleFonts.poppins(
                      color: AppColor.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget offer() {
    return Container(
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
            // Card(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            //   child:
            Image.asset(
              'assets/image/French-fries.png',
              height: 11.h,
              width: 11.h,
            ),
            // ),
          ],
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
            shrinkWrap: true,
            itemCount: 4,
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
                          builder: (context) => const DetailScreen())),
                  child: Container(
                    width: 10.w,
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
                        Container(
                          height: 11.h,
                          width: 12.h,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/image/Splesh.png'))),
                        ),
                        Text(
                          'Breef Burger',
                          style: GoogleFonts.poppins(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp),
                        ),
                        SizedBox(height: 1.5.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$24',
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
