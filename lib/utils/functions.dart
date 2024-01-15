
import 'package:flutter/material.dart';

void goToPage(BuildContext context, Widget page, [bool? showAsDialog]) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
      fullscreenDialog: showAsDialog ?? false,
    ),
  );
}


//show snackbar
Future notifyUser(BuildContext context, String? message,
    [Color? backColor]) async {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: backColor ?? Colors.black,
      dismissDirection: DismissDirection.up,
      content: Text(
        message!,
        style: const TextStyle(fontSize: 16),
      )));
}



