import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginScren extends StatefulWidget {
  const LoginScren({super.key});

  @override
  State<LoginScren> createState() => _LoginScrenState();
}

class _LoginScrenState extends State<LoginScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 240,
            ),
            child: Container(
              height: 150,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(390),
                    topLeft: Radius.circular(110)),
                color: Colors.yellow,
                shape: BoxShape.rectangle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 240, top: 543),
            child: Container(
              height: 150,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(110),
                  topRight: Radius.circular(390),
                ),
                color: Colors.yellow,
                shape: BoxShape.rectangle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//  Align(
//             alignment: Alignment.topRight,
//             child: Container(
//               height: 150,
//               width: 150,
//               decoration: BoxDecoration(
//                   color: Colors.yellow,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(100),
//                       bottomLeft: Radius.circular(100))),
//             ),
//           )