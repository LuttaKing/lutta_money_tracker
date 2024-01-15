import 'package:flutter/material.dart';
import 'package:lutta_money_tracker/utils/constants.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final String name;

  const AppButton({
    Key? key,
    this.onTap,
    this.color,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              foregroundColor: const Color(0xFFF2F8FB),
              backgroundColor: color ?? blueColor,
              padding: const EdgeInsets.symmetric(vertical: 16.5)),
          onPressed: onTap,
          child: Text(
            name,
            style: buttonTextStyle,
          )),
    );
  }
}

TextStyle buttonTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 17,
   
    fontWeight: FontWeight.w500);
