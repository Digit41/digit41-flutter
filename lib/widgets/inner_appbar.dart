import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InnerAppbar extends StatelessWidget {
  String title;
  Function? function;

  InnerAppbar({required this.title, this.function});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            if (function != null) function!();
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Center(),
      ],
    );
  }
}
