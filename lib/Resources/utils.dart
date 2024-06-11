import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLoadingDialog() {
  Get.dialog(
    barrierDismissible: false,
    const Center(child: CircularProgressIndicator()),
  );
}
