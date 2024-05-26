import 'package:education_app/core/common/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    required this.emailController,
    required this.formKey,
    super.key,
  });
  final TextEditingController emailController;

  final GlobalKey<FormState> formKey;

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          AppTextField(
            controller: widget.emailController,
            hintText: 'Email Address',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
