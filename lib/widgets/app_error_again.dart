import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppErrorAgain extends StatefulWidget {
  GestureTapCallback onReloadButtonTap;

  AppErrorAgain({required this.onReloadButtonTap});

  @override
  _AppErrorAgainState createState() => _AppErrorAgainState();
}

class _AppErrorAgainState extends State<AppErrorAgain> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          Strings.ERROR_OCCURRED.tr,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: ElevatedButton(
            onPressed: widget.onReloadButtonTap,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppTheme.gray),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.refresh, size: 20.0),
                const SizedBox(width: 32.0),
                Text(
                  Strings.TRY_AGAIN.tr,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
