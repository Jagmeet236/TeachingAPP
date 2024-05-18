import 'package:education_app/core/common/views/page_under_construction.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:education_app/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:education_app/src/authentication/presentation/view/forgot_password_screen.dart';
import 'package:education_app/src/authentication/presentation/view/sign_in_screen.dart';
import 'package:education_app/src/authentication/presentation/view/sign_up_screen.dart';
import 'package:education_app/src/dashBoard/presentation/views/dashboard.dart';
import 'package:education_app/src/on_boarding/data/dataSources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:education_app/src/on_boarding/presentation/views/on_Boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'router.main.dart';
