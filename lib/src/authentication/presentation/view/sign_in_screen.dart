import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/common/widgets/rounded_button.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:education_app/core/res/fonts.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:education_app/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:education_app/src/authentication/presentation/widgets/sign_in_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const routeName = '/sign-in';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                    Text(
                      'Easy to learn, discover more skills.',
                      style: TextStyle(
                        fontFamily: Fonts.aBeeZee.fontFamily,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Sign in to your account.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            '/sign-up',
                          );
                        },
                        child: const Text(
                          'Register account?',
                          style: TextStyle(
                            color: Colours.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SignInForm(
                      emailController: emailController,
                      passwordController: passwordController,
                      formKey: formKey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgot-password');
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Colours.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
                        label: 'Sign In',
                        onPressed: _onPressedSignIn,
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

  void _onPressedSignIn() {
    FocusManager.instance.primaryFocus?.unfocus();

    // refreshes the [current user’s] data from [Firebase
    // Authentication] when the [user] logs out and
    // logs in again
    FirebaseAuth.instance.currentUser?.reload();
    if (formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(
            SignInEvent(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ),
          );
    }
  }
}
