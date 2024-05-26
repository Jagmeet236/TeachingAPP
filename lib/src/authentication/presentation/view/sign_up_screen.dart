import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/common/widgets/rounded_button.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:education_app/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:education_app/src/authentication/presentation/widgets/auth_navigator_text_button.dart';
import 'package:education_app/src/authentication/presentation/widgets/authentication_heading.dart';
import 'package:education_app/src/authentication/presentation/widgets/sign_up_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const routeName = '/sign-up';
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
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
          } else if (state is SignedUp) {
            context.read<AuthenticationBloc>().add(
                  SignInEvent(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ),
                );
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(state.user as LocalUserModel);
            Navigator.pushReplacementNamed(context, '/dashboard');
          }
        },
        builder: (context, state) {
          return GradientBackground(
            image: MediaRes.authGradientBackground,
            child: SafeArea(
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  children: <Widget>[
                    const AuthenticationHeading(),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Sign Up for an account.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const AuthNavigatorTextButton(
                      buttonText: 'Already have an account?',
                      navigateTo: '/sign-in',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SignUpForm(
                      fullNameController: fullNameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                      formKey: formKey,
                    ),
                    const SizedBox(
                      height: 20,
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
                        label: 'Sign Up',
                        onPressed: _onPressedSignUp,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onPressedSignUp() {
    FocusManager.instance.primaryFocus?.unfocus();

    // refreshes the [current user’s] data from [Firebase
    // Authentication] when the [user] logs out and
    // logs in again
    FirebaseAuth.instance.currentUser?.reload();
    if (formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(
            SignUpEvent(
              fullName: fullNameController.text.trim(),
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ),
          );
    }
  }
}
