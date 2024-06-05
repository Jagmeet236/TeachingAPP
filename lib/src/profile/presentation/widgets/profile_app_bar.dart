import 'dart:async';
import 'package:education_app/core/common/widgets/popup_item.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(top: 10, left: 10),
        child: Text(
          'Account',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      actions: [
        PopupMenuButton(
          surfaceTintColor: Colors.white,
          offset: const Offset(0, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          itemBuilder: (_) => [
            PopupMenuItem<void>(
              child: const PopupItem(
                title: 'Edit Profile',
                icon: Icon(
                  IconlyLight.edit_square,
                  color: Colours.neutralTextColor,
                ),
              ),
              onTap: () => context.push(
                const Placeholder(),
              ),
            ),
            // second
            PopupMenuItem<void>(
              child: const PopupItem(
                title: 'Notification',
                icon: Icon(
                  IconlyLight.notification,
                  color: Colours.neutralTextColor,
                ),
              ),
              onTap: () => context.push(
                const Placeholder(),
              ),
            ),
            // third
            PopupMenuItem<void>(
              child: const PopupItem(
                title: 'Help',
                icon: Icon(
                  CupertinoIcons.question_circle,
                  color: Colours.neutralTextColor,
                ),
              ),
              onTap: () => context.push(
                const Placeholder(),
              ),
            ),
            // fourth
            PopupMenuItem<void>(
              child: const PopupItem(
                title: 'Log Out',
                icon: Icon(
                  IconlyLight.logout,
                  color: Colors.black,
                ),
              ),
              onTap: () async {
                final navigator = Navigator.of(context);
                await FirebaseAuth.instance.signOut();
                unawaited(
                  navigator.pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
