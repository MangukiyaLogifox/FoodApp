import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class CommonImage extends StatefulWidget {
  var height;
  var width;
  Color? color;
  String? image;
  CommonImage({super.key, this.height, this.width, this.image, this.color});
  @override
  State<CommonImage> createState() => _CommonImageState();
}

class _CommonImageState extends State<CommonImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      alignment: Alignment.center,
      width: widget.width,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: CachedNetworkImage(
        imageUrl: widget.image.toString(),
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
      ),
    );
  }
}
