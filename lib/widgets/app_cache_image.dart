import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  String url;
  Color? color;
  BoxFit? boxFit;
  double? size;

  CacheImage(this.url, {this.boxFit, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      color: color,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CupertinoActivityIndicator(),
      fit: boxFit ?? BoxFit.fill,
      width: size,
      height: size,
      errorWidget: (context, url, error) => Icon(Icons.image_outlined),
    );
  }
}
