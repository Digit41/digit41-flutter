import 'package:digit41/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void bottomSheet(String title,
    {String? message,
    Widget? child,
    bool enableDrag = true,
    bool isDismissible = true}) {
  Get.bottomSheet(
    Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Get.theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              if (isDismissible)
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close),
                ),
            ],
          ),
          if (message != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(message),
            ),
          child ?? Container(height: 0.0),
        ],
      ),
    ),
    isScrollControlled: true,
    enableDrag: enableDrag,
    isDismissible: isDismissible,
    backgroundColor: Get.theme.bottomSheetTheme.backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: const BorderRadius.only(
        topLeft: const Radius.circular(24.0),
        topRight: const Radius.circular(24.0),
      ),
    ),
  );
}

void confirmBottomSheet(String title, String mess,
    GestureTapCallback confirmOnTap, String confirmTxt,
    {bool negative = false}) {
  bottomSheet(
    title,
    message: mess,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: confirmOnTap,
          child: Text(
            confirmTxt,
            style: negative ? null : TextStyle(color: Get.theme.primaryColor),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            Strings.NO.tr,
            style: !negative ? null : TextStyle(color: Get.theme.primaryColor),
          ),
        ),
      ],
    ),
  );
}
