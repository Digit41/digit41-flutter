import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String message) {
  Get.showSnackbar(
    GetBar(
      message: message,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      borderRadius: 8.0,
    ),
  );
}
