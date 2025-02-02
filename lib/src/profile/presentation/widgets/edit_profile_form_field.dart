import 'package:education_app/core/common/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class EditProfileFormField extends StatelessWidget {
  const EditProfileFormField({
    required this.fieldTitle,
    required this.controller,
    this.hintText,
    super.key,
  });
  final String fieldTitle;
  final TextEditingController controller;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            fieldTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        AppTextField(
          controller: controller,
          hintText: hintText,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
