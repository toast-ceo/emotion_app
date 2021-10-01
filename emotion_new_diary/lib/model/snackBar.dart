import 'package:flutter/material.dart';

class SnackbarManager {
  static void showSnackBar(
      GlobalKey<ScaffoldState> scaffoldKey, String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
