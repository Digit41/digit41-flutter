import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget anyItemOfLanguageAndCurrency(String title, bool select, {onTap}) =>
    ListTile(
      onTap: onTap,
      title: Text(title, style: TextStyle(color: select ? Colors.white : null)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      tileColor: select ? AppTheme.gray : null,
      trailing: select
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.0),
                color: Get.theme.primaryColor,
              ),
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.check, color: Colors.black),
            )
          : null,
    );

Widget anyItemOfWalletAndNetwork(String title, bool select,
        {onTap, Widget? trailing}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        tileColor: select
            ? AppTheme.gray
            : darkModeEnabled()
                ? AppTheme.dark.scaffoldBackgroundColor
                : Colors.grey.shade300,
        title: Text(
          title,
          style: TextStyle(color: select ? Colors.white : null),
        ),
        trailing: trailing,
      ),
    );
