import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/src/authentication/data/dataSources/authentication_remote_data_source.dart';
import 'package:education_app/src/authentication/data/repositories/auth_repo_impl.dart';
import 'package:education_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/useCases/authentication_use_cases.dart';
import 'package:education_app/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:education_app/src/on_boarding/data/dataSources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/data/repositories/on_boarding_repo_impl.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app/src/on_boarding/domain/useCases/cache_first_timer.dart';
import 'package:education_app/src/on_boarding/domain/useCases/check_if_user_is_first_timer.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'injection_container.main.dart';
