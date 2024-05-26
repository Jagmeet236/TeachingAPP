import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/common/widgets/rounded_button.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:education_app/core/res/fonts.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:flutter/material.dart';

class ForgotPasswordSuccessWidget extends StatefulWidget {
  const ForgotPasswordSuccessWidget({required this.email, super.key});
  final String email;
  @override
  State<ForgotPasswordSuccessWidget> createState() =>
      _ForgotPasswordSuccessWidgetState();
}

class _ForgotPasswordSuccessWidgetState
    extends State<ForgotPasswordSuccessWidget> {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      image: MediaRes.authGradientBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                size: 100,
                color: Colours.greenColor,
              ),
              const SizedBox(height: 20),
              Text(
                'Password reset email sent successfully!',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: Fonts.aBeeZee.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'To this email address: ${widget.email}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              RoundedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sign-in');
                },
                label: 'Go Back',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
