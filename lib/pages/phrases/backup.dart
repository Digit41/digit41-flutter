import 'package:digit41/pages/phrases/phrases.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:digit41/widgets/app_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Backup extends StatefulWidget {
  @override
  _BackupState createState() => _BackupState();
}

class _BackupState extends State<Backup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Image.asset(
              Images.LOCK,
              height: 100.0,
              color: darkModeEnabled() ? null : Colors.black87,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                Strings.TITLE_BACKUP.tr,
                style: TextStyle(fontSize: 36.0),
              ),
            ),
            Expanded(
              child: Text(
                Strings.MESS_BACKUP.tr,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            AppCheckbox(
              Strings.MESS_ACCEPTING_CON.tr,
              AppButton(
                title: Strings.PROCEED.tr,
                btnColor: Get.theme.primaryColor,
                onTap: () {
                  navigateToPage(Phrases());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
