import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:education_app/src/profile/presentation/widgets/profile_box.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});
  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    debugPrint(context.currentUser!.fullName);
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        debugPrint(
          'this is the courses id ${context.currentUser!.enrolledCourseIds}',
        );
        final user = provider.user;
        final courses =
            user?.enrolledCourseIds == null || user!.enrolledCourseIds.isEmpty
                ? 0
                : user.enrolledCourseIds;
        final score = user?.points ?? 0;
        final followers = user?.followers == null || user!.followers.isEmpty
            ? 0
            : user.followers;
        final following = user?.following == null || user!.following.isEmpty
            ? 0
            : user.following;

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ProfileBox(
                    title: 'Courses',
                    icon: const Icon(
                      IconlyLight.document,
                      color: Colours.purpleColorDarker,
                      size: 24,
                    ),
                    bgColor: Colours.purpleColorLight,
                    data: courses,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ProfileBox(
                    title: 'Score',
                    icon: const Icon(
                      IconlyLight.chart,
                      color: Colours.greenColor,
                      size: 24,
                    ),
                    bgColor: Colours.languageTileColor,
                    data: score,
                  ),
                ],
              ),
              SizedBox(
                height: context.height * .03,
              ),
              Row(
                children: [
                  ProfileBox(
                    title: 'Followers',
                    icon: const Icon(
                      IconlyLight.user,
                      color: Colours.primaryColor,
                      size: 24,
                    ),
                    bgColor: Colours.literatureTileColor,
                    data: followers,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ProfileBox(
                    title: 'Following',
                    icon: const Icon(
                      IconlyLight.user_1,
                      color: Colours.redColorDarker,
                      size: 24,
                    ),
                    bgColor: Colours.chemistryTileColor,
                    data: following,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
