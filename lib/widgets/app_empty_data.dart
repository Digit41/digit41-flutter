import 'package:digit41/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppEmptyData extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Text(Strings.EMPTY_DATA.tr),
      ),
    );
  }
}
