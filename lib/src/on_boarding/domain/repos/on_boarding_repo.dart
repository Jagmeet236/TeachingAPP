import 'package:education_app/core/utils/typedef.dart';

abstract class OnBoardingRepo {
  const OnBoardingRepo();
  ResultFuture<void> cacheFirsTimer();

  ResultFuture<bool> checkIfUserIsFirstTimer();
}
