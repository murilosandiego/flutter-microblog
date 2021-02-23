import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class AppSnackbar {
  static void showSuccess({
    @required String message,
  }) {
    // Get.rawSnackbar(
    //   title: 'Sucesso',
    //   icon: Icon(
    //     Icons.thumb_up,
    //     color: Colors.white,
    //   ),
    //   message: message,
    //   backgroundColor: Colors.green[600],
    // );
  }

  static void showWarning({
    @required String message,
  }) {
    // Get.rawSnackbar(
    //   title: 'Atenção',
    //   icon: Icon(
    //     Icons.warning,
    //     color: Colors.white,
    //   ),
    //   message: message,
    //   backgroundColor: Colors.orange[900],
    // );
  }

  static void showError({
    @required String message,
  }) {
    // Get.rawSnackbar(
    //   title: 'Erro',
    //   icon: Icon(
    //     Icons.error,
    //     color: Colors.white,
    //   ),
    //   message: message,
    //   backgroundColor: Colors.redAccent[700],
    // );
  }
}
