import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingDialog {
  // static showLoadingDialog() {
  //   Get.dialog(
  //       Center(
  //         child: Container(
  //           height: 120,
  //           width: 120,
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //               color: Colors.white, borderRadius: BorderRadius.circular(14)),
  //           child: CircularProgressIndicator(),
  //         ),
  //       ),
  //       barrierDismissible: false);
  // }

  static showLoadingDialog() {
    Get.dialog(
        Center(
          child: Container(
            height: 120,
            width: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Lottie.asset("assets/loder.json"),
          ),
        ),
        barrierDismissible: false);
  }

  static showSuccessToast(String message) {
    Get.snackbar("Success", message,
        backgroundColor: Colors.green,
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  static showErrorToast(String message) {
    Get.snackbar("Error", message,
        backgroundColor: Colors.red,
        icon: const Icon(
          Icons.cancel_outlined,
          color: Colors.white,
        ),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  static hideLoading(){
    Get.back();
  }
}
