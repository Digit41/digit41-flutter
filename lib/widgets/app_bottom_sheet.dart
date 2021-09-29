import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void bottomSheet(String title,
    {String? message,
    Widget? child,
    Widget? frontOfTitle,
    bool enableDrag = true,
    bool isDismissible = true}) {
  Get.bottomSheet(
    Container(
      margin: const EdgeInsets.only(top: 36.0),
      padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
      decoration: BoxDecoration(
        color: Get.theme.bottomSheetTheme.backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: const Radius.circular(16.0),
          topRight: const Radius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12.0),
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
              frontOfTitle != null
                  ? frontOfTitle
                  : isDismissible
                      ? IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.close),
                        )
                      : Center(),
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
  );
}

void confirmBottomSheet(
  String title,
  String mess,
  GestureTapCallback confirmOnTap,
  String confirmTxt,
) {
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
            style: TextStyle(color: Get.theme.primaryColor),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            Strings.NO.tr,
            style: darkModeEnabled() ? TextStyle(color: Colors.white) : null,
          ),
        ),
      ],
    ),
  );
}
