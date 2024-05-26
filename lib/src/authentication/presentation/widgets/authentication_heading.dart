import 'package:education_app/core/res/fonts.dart';
import 'package:flutter/widgets.dart';

class AuthenticationHeading extends StatelessWidget {
  const AuthenticationHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Easy to learn, discover more skills.',
      style: TextStyle(
        fontFamily: Fonts.aBeeZee.fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
