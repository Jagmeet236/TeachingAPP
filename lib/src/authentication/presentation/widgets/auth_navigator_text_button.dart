import 'package:education_app/core/res/colours.dart';
import 'package:flutter/material.dart';

class AuthNavigatorTextButton extends StatelessWidget {
  const AuthNavigatorTextButton({
    required this.buttonText,
    required this.navigateTo,
    super.key,
    this.alignment = Alignment.centerRight,
    this.onPressed,
  });
  final String buttonText;
  final Alignment alignment;
  final VoidCallback? onPressed;
  final String navigateTo;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextButton(
        onPressed: onPressed ??
            () {
              Navigator.pushReplacementNamed(
                context,
                navigateTo,
              );
            },
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colours.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
