import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/extensions/string_extension.dart';
import 'package:education_app/src/profile/presentation/widgets/edit_profile_form_field.dart';
import 'package:flutter/material.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.oldPasswordController,
    required this.bioController,
    super.key,
  });
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController oldPasswordController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 10,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProfileFormField(
          fieldTitle: 'FULL NAME',
          controller: fullNameController,
          hintText: context.currentUser!.fullName,
        ),
        sizedBox,
        EditProfileFormField(
          fieldTitle: 'EMAIL',
          controller: emailController,
          hintText: context.currentUser!.email.obscureEmail,
        ),
        sizedBox,
        EditProfileFormField(
          fieldTitle: 'CURRENT PASSWORD',
          controller: oldPasswordController,
          hintText: '********',
        ),
        sizedBox,
        EditProfileFormField(
          fieldTitle: 'NEW PASSWORD',
          controller: passwordController,
          hintText: '********',
        ),
        sizedBox,
        EditProfileFormField(
          fieldTitle: 'BIO',
          controller: bioController,
          hintText: context.currentUser!.fullName,
        ),
        sizedBox,
      ],
    );
  }
}
