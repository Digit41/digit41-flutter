import 'package:digit41/utils/images_path.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

Widget fabAdd(String title, {onTap}) => Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    FloatingActionButton(
      onPressed: onTap,
      child: Image.asset(
        Images.PLUS_ADD,
        width: 25.0,
        height: 25.0,
      ),
    ),
    const SizedBox(height: 3.0),
    Text(
      title,
      style: TextStyle(color: Get.theme.primaryColor),
    ),
  ],
);