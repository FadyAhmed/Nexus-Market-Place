import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_market_place/constants.dart';
import 'package:ds_market_place/globals.dart' as globals;
import 'package:flutter/material.dart';

class MyCachedImg extends StatelessWidget {
  final String imageLink;
  final double width;
  final double height;

  const MyCachedImg(this.imageLink, this.width, this.height, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !globals.useCachedNetworkImage
        ? Image.asset(kLogo, width: width, height: height)
        : CachedNetworkImage(
            imageUrl: imageLink,
            errorWidget: (context, _, __) => Image.asset(
              kLogo,
              fit: BoxFit.scaleDown,
            ),
            fit: BoxFit.scaleDown,
            width: width,
            height: height,
          );
  }
}
