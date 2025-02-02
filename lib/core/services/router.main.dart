part of 'router.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final prefs = sl<SharedPreferences>();
      return _pageBuilder(
        (context) {
          if (prefs.getBool(kFirstTimerKey) ?? true) {
            return BlocProvider(
              create: (_) => sl<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            );
          } else if (sl<FirebaseAuth>().currentUser != null) {
            final user = sl<FirebaseAuth>().currentUser!;
            final localUser = LocalUserModel(
              uid: user.uid,
              email: user.email ?? '',
              points: 0,
              fullName: user.displayName ?? '',
              profilePic: user.photoURL ?? MediaRes.user,
              bio: 'Hi, I am using this app.',
            );
            context.userProvider.initUser(localUser);
            return const DashBoard();
          }
          return BlocProvider(
            create: (_) => sl<AuthenticationBloc>(),
            child: const SignInPage(),
          );
        },
        settings: settings,
      );
    case SignInPage.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthenticationBloc>(),
          child: const SignInPage(),
        ),
        settings: settings,
      );
    case SignUpPage.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthenticationBloc>(),
          child: const SignUpPage(),
        ),
        settings: settings,
      );
    case ForgotPasswordPage.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthenticationBloc>(),
          child: const ForgotPasswordPage(),
        ),
        settings: settings,
      );
    case DashBoard.routeName:
      return _pageBuilder(
        (_) => const DashBoard(),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
