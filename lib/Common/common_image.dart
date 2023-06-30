import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CommonImage extends StatelessWidget {
  var height;
  var width;
  Color? color;
  String? image;
  CommonImage({super.key, this.height, this.width, this.image, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      width: width,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.network(
        image.toString(),
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
    );
  }
}
