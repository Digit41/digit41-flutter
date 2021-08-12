import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InnerAppbar extends StatelessWidget implements PreferredSizeWidget {
  String title;

  InnerAppbar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(58.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Get.theme.primaryColor,
        ),
      ),
      title: Text(title, style: TextStyle(fontSize: 20.0)),
    );
  }
}
