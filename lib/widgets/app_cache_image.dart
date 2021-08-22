import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  String url;
  Color? color;
  BoxFit? boxFit;

  CacheImage(this.url, {this.boxFit, this.color});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      color: color,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CupertinoActivityIndicator(),
      fit: boxFit ?? BoxFit.fill,
      errorWidget: (context, url, error) => Icon(
        Icons.image_outlined,
        size: 17.0,
        color: Colors.grey,
      ),
    );
  }
}
