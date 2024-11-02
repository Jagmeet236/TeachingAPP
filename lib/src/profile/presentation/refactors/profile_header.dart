import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});
  @override
  Widget build(BuildContext context) {
    debugPrint('Profile pic ${context.currentUser!.profilePic}');
    debugPrint(context.currentUser!.fullName);
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        final image = user?.profilePic == null || user!.profilePic!.isEmpty
            ? null
            : user.profilePic;
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: image != null
                    ? NetworkImage(image)
                    : Image.asset(MediaRes.user) as ImageProvider,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                user?.fullName ?? 'No User',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              if (user?.bio != null && user!.bio!.isNotEmpty) ...[
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * .15,
                  ),
                  child: Text(
                    user.bio!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colours.neutralTextColor,
                    ),
                  ),
                ),
              ],
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        );
      },
    );
  }
}
