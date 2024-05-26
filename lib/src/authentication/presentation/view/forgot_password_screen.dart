import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/common/widgets/rounded_button.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:education_app/src/authentication/presentation/widgets/auth_navigator_text_button.dart';
import 'package:education_app/src/authentication/presentation/widgets/authentication_heading.dart';
import 'package:education_app/src/authentication/presentation/widgets/forgot_password_form.dart';
import 'package:education_app/src/authentication/presentation/widgets/forgot_password_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  static const routeName = '/forgot-password';
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (_, state) {
          if (state is AuthenticationError) {
            CoreUtils.showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is ForgotPasswordSent) {
            return ForgotPasswordSuccessWidget(
              email: emailController.text,
            );
          }
          return GradientBackground(
            image: MediaRes.authGradientBackground,
            child: Center(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                shrinkWrap: true,
                children: [
                  const AuthenticationHeading(),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Forgot Password.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const AuthNavigatorTextButton(
                    buttonText: 'Return to Sign In?',
                    navigateTo: '/sign-in',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ForgotPasswordForm(
                    emailController: emailController,
                    formKey: formKey,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (state is AuthenticationLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    RoundedButton(
                      label: 'Forgot Password',
                      onPressed: _onPressedForgotPassword,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onPressedForgotPassword() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(
            ForgotPasswordEvent(
              emailController.text.trim(),
            ),
          );
    }
  }
}
