import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/utils.dart';
import 'package:flutter/material.dart';

class NFTDetail extends StatelessWidget {
  Widget item() => Container(
        decoration: BoxDecoration(
          color: darkModeEnabled() ? AppTheme.gray : Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: darkModeEnabled() ? Colors.black87 : Colors.white,
            ),
          ],
        ),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: Image.asset(Images.LOGO, height: 400.0, width: 200.0)),
            const SizedBox(height: 4.0),
            Text(
              'ASTRO-934',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'ASTRO-934 is the best...',
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 24.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  item(),
                  item(),
                  item(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
