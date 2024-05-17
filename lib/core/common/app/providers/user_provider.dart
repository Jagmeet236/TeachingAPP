import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  LocalUserModel? _user;

  LocalUserModel? get user => _user;

// Updates the [_user] field with the new user value if they are not the same
  void initUser(LocalUserModel? user) {
    if (_user != user) _user = user;
  }

  set user(LocalUserModel? user) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
