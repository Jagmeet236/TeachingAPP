import 'package:education_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Allow the back action to happen
      child: IconButton(
        onPressed: () {
          try {
            context.pop(); // Standard Navigator pop for normal navigation
          } catch (e) {
            debugPrint('An error occurred at back button: $e');
            Navigator.of(context)
                .pop(); // Handle any potential fallback if needed
          }
        },
        icon: Theme.of(context).platform == TargetPlatform.iOS
            ? const Icon(Icons.arrow_back_ios_new)
            : const Icon(Icons.arrow_back),
      ),
    );
  }
}
